//
//  Symbols.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/20.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  符号表
 */
@interface Symbols : NSObject

/**
 *  美式音标
 */
@property (nonatomic,copy) NSString *ph_am;

/**
 *  英式音标
 */
@property (nonatomic,copy) NSString *ph_en;

/**
 *  中文拼音
 */
@property (nonatomic,copy) NSString *ph_zh;

/**
 *  每个翻译的词性数组
 */
@property (nonatomic,strong) NSArray *parts;

@end
