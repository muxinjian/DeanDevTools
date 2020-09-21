//
//  DeanToolFPS.h
//  DeanToolFPS
//
//  Created by muxinjian on 2019/4/25.
//  Copyright © 2019年https://www.github.com/muxinjianAll rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^DeanToolFPSBlock)(float fps);

@interface DeanToolFPS : NSObject

/**
 监测过程中输出FPS的回调
 */
@property (nonatomic, copy) DeanToolFPSBlock FPSBlock;

/**
 单例对象
 */
+ (DeanToolFPS *)shareInstance;

/**
 开始监测
 */
- (void)startMonitoring;

/**
 暂停监测
 */
- (void)pauseMonitoring;

/**
 移除监测
 */
- (void)removeMonitoring;

@end
