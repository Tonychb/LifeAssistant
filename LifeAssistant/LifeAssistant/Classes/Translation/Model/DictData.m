//
//  DictData.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/22.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "DictData.h"

@implementation DictData

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray
{
    // 实现这个方法的目的：告诉MJExtension框架模型里的数组里面装的是什么模型
    return @{@"symbols":@"Symbols"};
}

@end
