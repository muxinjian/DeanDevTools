//
//  DeanClangTrace.m
//  HTScore_iOS
//
//  Created by muxinjian on 2020/6/3.
//  Copyright © 2020 huatu. All rights reserved.
//


#import "DeanClangTrace.h"
#import <dlfcn.h>
#import <libkern/OSAtomic.h>

@implementation DeanClangTrace

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                         uint32_t *stop) {
    static uint64_t N;  // Counter for the guards.
    if (start == stop || *start) return;  // Initialize only once.
    for (uint32_t *x = start; x < stop; x++)
        *x = ++N;  // Guards should start from 1.
}
//原子队列
static  OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;
//定义符号结构体
typedef struct {
    void *pc;
    void *next;
} SymbolNode;
void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    if (!*guard) return;
    void *PC = __builtin_return_address(0);
    SymbolNode *node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC, NULL};
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));
}

+ (void)generateOrderFile {
    NSMutableArray <NSString *> *symbolNames = [NSMutableArray array];
    while (YES) {
        SymbolNode * node = OSAtomicDequeue(&symbolList, offsetof(SymbolNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        NSString *name = @(info.dli_sname);
        // 判断是不是oc方法，是的话直接加入符号数组
        BOOL isInstanceMethod = [name hasPrefix:@"-["];
        BOOL isClassMethod = [name hasPrefix:@"+["];
        BOOL isObjc = isInstanceMethod || isClassMethod;
        NSString * symbolName = isObjc ? name: [@"_" stringByAppendingString:name];
        [symbolNames addObject:symbolName];
    }
    // 取反:将先调用的函数放到前面
    NSEnumerator * emt = [symbolNames reverseObjectEnumerator];
    // 去重：由于一个函数可能执行多次，__sanitizer_cov_trace_pc_guard会执行多次，就加了重复的了，所以去重一下
    NSMutableArray<NSString *> *funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString *name;
    while (name = [emt nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    // 由于trace了所有执行的函数，这里我们就把本函数移除掉
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    // 写order文件
    NSString *funcStr = [funcs componentsJoinedByString:@"\n"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"DeanClangTrace.order"];
    NSData *fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
         NSLog(@"orderPath:%@",filePath);
    }else{
         NSLog(@"生成orderPath失败");
    }
}
#pragma mark - Util

+ (BOOL)isObjcMethodBySymbolName:(NSString *)symbolName {
    
    BOOL isInstanceMethod = [symbolName hasPrefix:@"-["];
    BOOL isClassMethod = [symbolName hasPrefix:@"+["];
    return isInstanceMethod || isClassMethod;
}

@end
