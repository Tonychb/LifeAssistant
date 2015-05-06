//
//  NSString+ExtensionMethods.h
//  JewelryLion
//
//  Created by zhubaoshi on 14/11/7.
//  Copyright (c) 2014年 JewelryLion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExtensionMethods)

///自定义字符串拼接方法
- (NSString *)StringConcatenation:(NSString *)string;

///中文转拼音
+ (NSString *)chineseChangePinyin:(NSString *)sourceString;


///手机号码的有效性判断,检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//验证邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email;

@end
