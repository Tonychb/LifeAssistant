//
//  HttpTool.h
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/6.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

//*****************网络请求工具类，负责整个项目中所有的Http网络请求*****************

//用typedef定义函数名为Success返回值为void的block类型,带参数(id responseObj)
typedef void(^Success)(id responseObj);

typedef void(^Failure)(NSError *error);

@interface HttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  发送一个POST请求(带图片上传)
 *
 *  @param url       请求路径
 *  @param params    请求参数
 *  @param imageData 图片的data类型的数据
 *  @param imageName 上传的图片参数名
 *  @param success   请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure   请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData imageName:(NSString *)imageName success:(Success)success failure:(Failure)failure;

@end
