//
//  TranslationModel.h
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
 *  翻译数据模型
 */
@interface TranslationModel : NSObject

//只有发生错误时，返回的JSON中才包含error_code和error_msg字段，成功返回的结果中不会包含这两个字段。
/**
 *  错误码
 */
@property (nonatomic,copy) NSString *error_code;

/**
 *  错误信息
 */
@property (nonatomic,copy) NSString *error_msg;

/**
 *  源语言
 */
@property (nonatomic,copy) NSString *from;

/**
 *  目标语言
 */
@property (nonatomic,copy) NSString *to;

/**
 *  翻译结果数组
 */
@property (nonatomic,strong) NSArray *trans_result;


@end
