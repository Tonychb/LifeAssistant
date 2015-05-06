//
//  HttpTool.m
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/6.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool


/**
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure
{
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //请求失败：不能接受的内容类型： text / html的,添加以下一句话
    // Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //发送Get请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将方法中的实参传给内部的Success Block调用
        if (success)
        {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //将方法中的error传给内部的Failure Block调用
        if (failure)
        {
            failure(error);
        }
        
        
    }];
}


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure
{
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //请求失败：不能接受的内容类型： text / html的,添加以下一句话
    // Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //发送POST请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将方法中的实参传给内部的Success Block调用
        if (success)
        {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //将方法中的error传给内部的Failure Block调用
        if (failure)
        {
            failure(error);
        }
        
    }];
    
}


+ (void)post:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData imageName:(NSString *)imageName success:(Success)success failure:(Failure)failure
{
    //********************上传多张图片******************
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //请求失败：不能接受的内容类型： text / html的,添加以下一句话
    // Request failed: unacceptable content-type: text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //发送POST请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (imageData != nil)
        {
            [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/*"];
            
        }

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将方法中的实参传给内部的Success Block调用
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //将方法中的error传给内部的Failure Block调用
        if (failure)
        {
            failure(error);
        }
        
    }];
    
    
}



@end
