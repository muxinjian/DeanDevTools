//
//  AES256Crypt.h
//  AES256
//
//  Created by Dean on 17/4/26.
//  Copyright © 2017年 muxinjian/01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"
#import "NSString+Base64.h"

@interface NSData (Encryption)
/// 加密
- (NSData *)AES256Encrypt;
/// 解密
- (NSData *)AES256Decrypt;
/// string 转 bytes
- (NSString *)dataBytes;
@end

@interface NSString (NSStringHexToBytes)
/// 加密
-(NSString *)AESEncryptString;
/// 解密
-(NSString *)AESDecryptString;

-(NSData*) hexToBytes ;

@end

@interface NSDictionary (NSDictionaryAES)
/// 加密
-(NSString *)AESEncryptJSONString;
/// 解密
-(NSDictionary *)AESDecryptJSONString:(NSString *)jsonStr;

@end
