//
//  DeanToolFPS.m
//  DeanToolFPS
//
//  Created by muxinjian on 2019/4/25.
//  Copyright © 2019年https://www.github.com/muxinjian All rights reserved.
//

#import "DeanToolFPS.h"

@interface DeanToolFPS()

/** 计时器 */
@property (nonatomic, strong)  CADisplayLink *displayLink;
/** 1秒的刷新次数 */
@property (nonatomic, assign)  NSInteger count;
/** 开始计时的屏幕渲染的时间点 */
@property (nonatomic, assign)  NSInteger beginTime;

@end

@implementation DeanToolFPS

+ (DeanToolFPS *)shareInstance {
    static dispatch_once_t onceToken;
    static DeanToolFPS *fps;
    dispatch_once(&onceToken, ^{
        fps = [[DeanToolFPS alloc] init];
    });
    return fps;
}

- (instancetype)init{
    
    if (self = [super init]) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

#pragma mark -- Help Methods

/**
 开始监测
 */
- (void)startMonitoring{
     _displayLink.paused = NO;
}

/**
 暂停监测
 */
- (void)pauseMonitoring{
    _displayLink.paused = YES;
}

/**
 移除监测
 */
- (void)removeMonitoring{
    [self pauseMonitoring];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_displayLink invalidate];
}

#pragma mark -- Event Handle

//这个方法的执行频率跟当前屏幕的刷新频率是一样的，屏幕每渲染刷新一次，就执行一次，那么1秒的时长执行刷新的次数就是当前的FPS值
- (void)displayLinkTick:(CADisplayLink *)link{
    
    //     duration 是只读的， 表示屏幕刷新的间隔 = 1/fps
    //     timestamp 是只读的， 表示上次屏幕渲染的时间点
    //    frameInterval 是表示定时器被触发的间隔， 默认值是1， 就是表示跟屏幕的刷新频率一致。
    //    NSLog(@"timestamp= %f  duration= %f frameInterval= %f",link.timestamp, link.duration, frameInterval);
    
    //初始化屏幕渲染的时间
    if (_beginTime == 0) {
        _beginTime = link.timestamp;
        return;
    }
    //刷新次数累加
    _count++;
    //刚刚屏幕渲染的时间与最开始幕渲染的时间差
    // 渲染的时间差
    NSTimeInterval interval = link.timestamp - _beginTime;
    if (interval < 1) {
        //不足1秒，继续统计刷新次数
        return;
    }
    //刷新频率
    float fps = _count / interval;
    
    if (self.FPSBlock != nil) {
        self.FPSBlock(fps);
    }

    //1秒之后，初始化时间和次数，重新开始监测
    _beginTime = link.timestamp;
    _count = 0;
}

- (void)dealloc{
    [self removeMonitoring];
}

@end
