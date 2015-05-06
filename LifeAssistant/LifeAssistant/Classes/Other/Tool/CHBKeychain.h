//
//  CHBKeychain.h
//  keychain的使用
//
//  Created by zhubaoshi on 15/3/13.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  keychain的使用
    需要导入Security.framework
    引入文件 #import <Security/Security.h>
 */
@interface CHBKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end
