//
//  NSString+Base64.h
//  Dean
//
//  Created by Dean on 17/4/26.
//  Copyright © 2017年 muxinjian/01. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSString (Base64Additions)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
