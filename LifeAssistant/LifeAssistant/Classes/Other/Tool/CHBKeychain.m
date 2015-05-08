//
//  CHBKeychain.m
//  keychain的使用
//
//  Created by zhubaoshi on 15/3/13.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import "CHBKeychain.h"

@implementation CHBKeychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,service,(__bridge_transfer id)kSecAttrService,service,(__bridge_transfer id)kSecAttrAccount,(__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,nil];
}

+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary 获取搜索字典
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item 删除旧项目之前添加新项
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    //添加新的对象来搜索字典（注意：数据格式）
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    //添加物品到钥匙圈与搜索字典
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
    [keychainQuery removeAllObjects];
    keychainQuery = nil;
}

+ (id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting 配置搜索设置
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            //Code that can potentially throw an exception
            //这可能会抛出异常的代码
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        }
        @catch (NSException *exception) {
            //Handle an exception thrown in the @try block
            //处理扔在@try块异常
            NSLog(@"Unarchive of取消封存 %@ failed失败: %@",service,exception);
        }
        @finally {
            //Code that gets executed whether or not an exception is thrown
            //所执行的异常是否抛出代码
        }

    }
    
    return ret;
}

+ (void)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery removeAllObjects];
    keychainQuery = nil;
}

@end
