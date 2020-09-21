//
//  DNCallStack.h
//  DNCallStack
//
//  Created by Dean on 2020/7/19.
//  Copyright © 2020 muxinjian. All rights reserved.
//  获取函数调用栈

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define DNLOG_Callstack_Current NSLog(@"%@",[BSBacktraceLogger DN_backtraceOfCurrentThread]);
#define DNLOG_Callstack_MAIN NSLog(@"%@",[BSBacktraceLogger DN_backtraceOfMainThread]);
#define DNLOG_Callstack_ALL NSLog(@"%@",[BSBacktraceLogger DN_backtraceOfAllThread]);

/**
 获取函数调用栈
 Xcode 的调试输出不稳定，有时候存在调用 NSLog() 但没有输出结果的情况，建议前往 控制台 中根据设备的 UUID 查看完整输出。
 真机调试和使用 Release 模式时，为了优化，某些符号表并不在内存中，而是存储在磁盘上的 dSYM 文件中，无法在运行时解析，因此符号名称显示为 <redacted>。
 关于dSYM可以参考https://github.com/answer-huang/dSYMTools
 */

@interface DNCallStack : NSObject

+ (NSString *)DN_backtraceOfAllThread;
+ (NSString *)DN_backtraceOfCurrentThread;
+ (NSString *)DN_backtraceOfMainThread;
+ (NSString *)DN_backtraceOfNSThread:(NSThread *)thread;

@end

NS_ASSUME_NONNULL_END
