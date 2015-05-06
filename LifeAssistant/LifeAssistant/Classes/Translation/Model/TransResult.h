//
//  TransResult.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/20.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

/*
 当对自定义的类进行归档时，无法保存对象，只是需要在自定义类中实现NSCoding协议。
 实现两个方法:
 //本身的类进行转码，编码
 - (void)encodeWithCoder:(NSCoder *)encoder;
 
 //一个是逆转码成类对象，返回一个对象。解码
 - (id)initWithCoder:(NSCoder *)decoder;
 */

#import <Foundation/Foundation.h>
/**
 *  翻译结果
 */
@interface TransResult : NSObject

/**
 *  译文
 */
@property (nonatomic,copy) NSString *dst;

/**
 *  原文
 */
@property (nonatomic,copy) NSString *src;


@end
