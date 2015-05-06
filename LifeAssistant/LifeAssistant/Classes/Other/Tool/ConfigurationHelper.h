//
//  ConfigurationHelper.h
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/4/3.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  使用NSUserDefaults类来保存用户的设置，配置助手
 */
@interface ConfigurationHelper : NSObject

/**
 *  设置应用程序启动默认值
 */
+ (void)setApplicationStartupDefaults;

/**
 *  返回布尔值对于配置key
 *
 *  @param _objectkey 对象的key
 *
 *  @return 返回布尔值
 */
+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey;

/**
 *  设置布尔值对于配置key
 *
 *  @param _objectkey 对象的key
 *  @param _boolvalue 布尔值
 */
+ (void)setBoolValueForConfigurationKey:(NSString *)_objectkey withValue:(BOOL)_boolvalue;

/**
 *  得到字符串值配置key
 *
 *  @param _objectkey 对象的key
 *
 *  @return 返回字符串值
 */
+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey;

/**
 *  设置字符串值配置key
 *
 *  @param _objectkey 对象的key
 *  @param _value     字符串值
 */
+ (void)setStringValueForConfigurationKey:(NSString *)_objectkey withValue:(NSString *)_value;





@end
