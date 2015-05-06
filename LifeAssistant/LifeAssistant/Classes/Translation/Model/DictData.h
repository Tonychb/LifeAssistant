//
//  DictData.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/22.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictData : NSObject

/**
 *  请求的词语
 */
@property (nonatomic,copy) NSString *word_name;

/**
 *  符号表
 */
@property (nonatomic,strong) NSArray *symbols;

@end
