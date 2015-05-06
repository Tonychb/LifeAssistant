//
//  CHBUserDataManager.h
//  keychain的使用
//
//  Created by zhubaoshi on 15/3/13.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBUserDataManager : NSObject

///存储密码和用户名
+ (void)savePassWord:(NSString *)password username:(NSString *)username;

///读取密码
+ (id)readPassWord;

///读取用户名
+ (id)readUserName;

///删除密码和用户名
+ (void)deletePassWordAndUserName;

@end
