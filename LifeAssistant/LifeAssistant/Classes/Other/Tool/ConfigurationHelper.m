//
//  ConfigurationHelper.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/4/3.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "ConfigurationHelper.h"

@implementation ConfigurationHelper

#pragma mark - 设置应用程序启动默认值
+ (void)setApplicationStartupDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    //首先启动
    [defaults setBool:NO forKey:kFirstLaunch];
    //身份验证
    [defaults setBool:NO forKey:kAuthenticated];
    //同步
    [defaults synchronize];
}

#pragma mark - 返回布尔值对于配置key
+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey
{
    //创建NSUserDefaults的实例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //让我们确保对象同步
    [defaults synchronize];
    
    return [defaults boolForKey:_objectkey];
}

#pragma mark - 设置布尔值对于配置key
+ (void)setBoolValueForConfigurationKey:(NSString *)_objectkey withValue:(BOOL)_boolvalue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //让我们确保对象同步
    [defaults synchronize];
    [defaults setBool:_boolvalue forKey:_objectkey];
    //确保你再次同步
    [defaults synchronize];
}

#pragma mark - 得到字符串值配置key
+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey
{
    //创建NSUserDefaults的实例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //让我们确保对象同步
    [defaults synchronize];
    if ([defaults stringForKey:_objectkey] == nil )
    {
        //我不想(null)返回的，因为其结果可能是一个UILabel的文本属性
        return @"";
    }
    else
    {
        return [defaults stringForKey:_objectkey];
    }

}

#pragma mark - 设置字符串值配置key
+ (void)setStringValueForConfigurationKey:(NSString *)_objectkey withValue:(NSString *)_value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //让我们确保对象同步
    [defaults synchronize];
    [defaults setValue:_value forKey:_objectkey];
    //确保你再次同步
    [defaults synchronize];
}


@end
