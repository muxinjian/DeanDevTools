//
//  NSData+Base64.m
//  Dean
//
//  Created by Dean on 17/4/26.
//  Copyright © 2017年 muxinjian/01. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string;

@end
