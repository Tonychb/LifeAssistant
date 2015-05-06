//
//  CHBUserDataManager.m
//  keychain的使用
//
//  Created by zhubaoshi on 15/3/13.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import "CHBUserDataManager.h"
#import "CHBKeychain.h"

@implementation CHBUserDataManager

//首先需要定义几个字符串用来做key：
static NSString * const KEY_IN_KEYCHAIN = @"com.JewelryLion-EC.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.JewelryLion-EC.app.password";
static NSString * const KEY_USERNAME = @"com.JewelryLion-EC.app.username";


#pragma mark -  把用户名和密码存入keychain
+ (void)savePassWord:(NSString *)password username:(NSString *)username
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [usernamepasswordKVPairs setObject:username forKey:KEY_USERNAME];
    [CHBKeychain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

#pragma mark - 从keychain中取出用户名和密码
#pragma mark 读取密码
+ (id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[CHBKeychain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}
#pragma mark 读取用户名
+ (id)readUserName
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[CHBKeychain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_USERNAME];
}

#pragma mark - 删除一个keychain item
+ (void)deletePassWordAndUserName;
{
    [CHBKeychain delete:KEY_IN_KEYCHAIN];
}

@end
