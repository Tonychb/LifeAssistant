//
//  NSString+MD5.m
//  MyPersonalLibrary
//  This file is part of source code lessons that are related to the book
//  Title: Professional IOS Programming
//  Publisher: John Wiley & Sons Inc
//  ISBN 978-1-118-66113-0
//  Author: Peter van de Put
//  Company: YourDeveloper Mobile Solutions
//  Contact the author: www.yourdeveloper.net | info@yourdeveloper.net
//  Copyright (c) 2013 with the author and publisher. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)
- (NSString*)MD5
{
    // 创建指向字符串UTF8
    const char *ptr = [self UTF8String];
    
    // 创建无符号的字符的字节数组
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // 创建16个字节的MD5哈希值，存储在缓冲区
    /*CC_MD5(str,strlen(str), r);
    改成了CC_MD5(str, (CC_LONG)strlen(str), r);即可。
    */
    //CC_MD5(ptr, strlen(ptr), md5Buffer);
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    // 转换无符号字符缓冲区十六进制值的NSString
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}
@end
