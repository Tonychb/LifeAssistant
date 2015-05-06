//
//  DictionaryModel.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/22.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DictData;

/**
 *  词典数据模型
 */
@interface DictionaryModel : NSObject

/**
 *  词典里的数据
 */
@property (nonatomic,strong) DictData *data;

/**
 *  词典数据模型的错误码
 */
@property (nonatomic,strong) NSNumber *dictErrno;

/**
 *  词典数据模型的错误信息
 */
@property (nonatomic,strong) NSString *dictErrmsg;

/**
 *  源语言
 */
@property (nonatomic,copy) NSString *from;

/**
 *  目标语言
 */
@property (nonatomic,copy) NSString *to;




@end
