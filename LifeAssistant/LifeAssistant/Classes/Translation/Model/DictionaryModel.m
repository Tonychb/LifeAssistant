//
//  DictionaryModel.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/22.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "DictionaryModel.h"

@implementation DictionaryModel


/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    // 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
    return @{@"dictErrno":@"errno",@"dictErrmsg":@"errmsg"};
}

@end
