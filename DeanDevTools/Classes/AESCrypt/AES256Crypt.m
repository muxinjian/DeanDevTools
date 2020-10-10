//
//  AES256Crypt.m
//  lingMoney
//
//  Created by Dean on 17/4/26.
//  Copyright © 2017年 muxinjian/01. All rights reserved.
//


#import "AES256Crypt.h"


@implementation NSDictionary (NSDictionaryAES)

-(NSString *)AESEncryptJSONString{
 
    return [[self mj_JSONString]  AESEncryptString];
}

-(NSDictionary *)AESDecryptJSONString:(NSString *)jsonStr{
   
    return [jsonStr isEqual:[NSNull null]] ? nil :[NSDictionary dictionaryWithDictionary:[[jsonStr AESDecryptString] mj_JSONObject]];
}
@end
@implementation NSString (NSStringHexToBytes)
-(NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
-(NSString *)AESEncryptString{
    
  
    NSData *plainTextData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherTextData = [plainTextData AES256Encrypt] ;
    return [NSString base64StringFromData:cipherTextData length:[cipherTextData length]];
    
}


-(NSString *)AESDecryptString{

    NSData *plainTextData = [NSData base64DataFromString:self];
    NSData *cipherTextData = [plainTextData AES256Decrypt];
    NSString *result = [[NSString alloc] initWithData:cipherTextData  encoding:NSUTF8StringEncoding];
    return result;
}
@end


//static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static  Byte keyByte[] = {0x0b,0x09,0x04,0x0b,0x02,0x0f,0x0b,0x0c,0x01,0x03,0x09,0x07,0x0c,0x03,0x0f,0x0a,0x04,0x0f,0x1a,0x0f,0x0e,0x09,0x05,0x01,0x0a,0x0a,0x01,0x0e,0x06,0x07,0x09,0x0d};

@implementation NSData (Encryption)

- (NSData *)AES256Encrypt   //加密
{

    //byte转换为NSData类型，以便下边加密方法的调用
    NSData *key = [[NSData alloc] initWithBytes:keyByte length:32];
   
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
   
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*PKCS7Padding填充*/ | kCCOptionECBMode,
                                          [key bytes], kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes], dataLength,/*输入*/
                                          buffer, bufferSize,/* 输出 */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);//释放buffer
    return nil;
}


- (NSData *)AES256Decrypt  //解密
{

    //byte转换为NSData类型，以便下边加密方法的调用
    NSData *key = [[NSData alloc] initWithBytes:keyByte length:32];
    //同理，解密中，密钥也是32位的
    const void * keyPtr2 = [key bytes];
    char (*keyPtr)[32] = keyPtr2;
    
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*PKCS7Padding填充*/ | kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes], dataLength,/* 输入 */
                                          buffer, bufferSize,/* 输出 */
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

-(NSString *)dataBytes{
    NSMutableString *output = [NSMutableString stringWithCapacity:self.length * 2];
       Byte *plainTextByte = (Byte *)[self bytes];
    for(int i=0;i<[self length];i++){
        
        [output appendFormat:@"%02x", plainTextByte[i]];
    }
 
    return output ;
}




@end
