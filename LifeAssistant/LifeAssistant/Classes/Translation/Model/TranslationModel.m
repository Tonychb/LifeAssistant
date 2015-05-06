//
//  TranslationModel.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/20.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "TranslationModel.h"

//static NSString *const kTranslationModelErrMsg = @"errMsg";
//static NSString *const kTranslationModelErrNum = @"errNum";
//static NSString *const kTranslationModelRetData = @"retData";

@implementation TranslationModel

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray
{
    // 实现这个方法的目的：告诉MJExtension框架模型里的数组里面装的是什么模型
    return @{@"trans_result":@"TransResult"};
}

//- (id)initTranslationModelWithDict:(NSDictionary *)dict
//{
//    self = [super init];
//    if (self) {
//        
//        
//    }
//    return self;
//}
//
//+ (id)translationModelWithDict:(NSDictionary *)dict
//{
//    return [[self alloc]initTranslationModelWithDict:dict];
//}
//
////一个类的对象进行转码，编码
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    //类内部的两个属性变量分别转码
//    [encoder encodeObject:_errMsg forKey:kTranslationModelErrMsg];
//    [encoder encodeObject:_errNum forKey:kTranslationModelErrNum];
//    [encoder encodeObject:_retData forKey:kTranslationModelRetData];
//
//}
////一个是逆转码成类对象，返回一个对象。解码
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    //分别把两个属性变量根据关键字进行逆转码，最后返回一个类的对象
//    self = [super init];
//    if (self)
//    {
//        self.errMsg = [decoder decodeObjectForKey:kTranslationModelErrMsg];
//        self.errNum = [decoder decodeObjectForKey:kTranslationModelErrNum];
//        self.retData = [decoder decodeObjectForKey:kTranslationModelRetData];
//    }
//    return self;
//}


@end
