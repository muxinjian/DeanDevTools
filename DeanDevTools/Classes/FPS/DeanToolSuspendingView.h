//
//  DeanToolSuspendingView.h
//  DeanToolFPS
//
//  Created by muxinjian on 2019/4/25.
//  Copyright © 2019年https://www.github.com/muxinjian All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//悬浮窗口
@interface DeanToolSuspendingView : NSObject

/**
 展示FPS的视图
 */
@property (nonatomic, strong) UILabel * fpsLabel;

/**
 单例
 */
+ (DeanToolSuspendingView *)sharedSuspendingView;

/**
 关闭悬浮窗视图
 */
- (void)closeSuspendingView;

@end
