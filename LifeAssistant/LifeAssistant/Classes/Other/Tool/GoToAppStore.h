//
//  GoToAppStore.h
//  JewelryLion
//
//  Created by zhubaoshi on 15/3/9.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

/*
 //应用实现评论跳转的两种方法：
 //第一种：
 //在iOS6.0前跳转到AppStore评分一般是直接跳转到AppStore评分
 iOS7之后:[[UIApplicationsharedApplication]openURL:[NSURLURLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
 //这种方法实现了跳转到AppStore评分功能。
 
 //第二种：
 //在iOS6.0，Apple增加了一个心得功能，当用户需要给APP评分时候，不再跳转到AppStore了，可以在应用内实现打开appstore，苹果提供了一个框架StoreKit.framework,实现步骤如下:
 //1:导入StoreKit.framework,在需要跳转的控制器里面添加头文件#import
 //2:实现代理SKStoreProductViewControllerDelegate
 
 //代码如下：
 //初始化控制器
 SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
 //设置代理请求为当前控制器本身
 storeProductViewContorller.delegate = self;
 //加载一个新的视图展示
 [storeProductViewContorller loadProductWithParameters:
 //appId
 @{SKStoreProductParameterITunesItemIdentifier : @"961511226"} completionBlock:^(BOOL result, NSError *error) {
 //block回调
 if(error){
 NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
 }else{
 //模态弹出AppStore应用界面
 [self presentViewController:storeProductViewContorller animated:YES completion:^{
 
 }
 ];
 }
 }];
 
 */


#import <Foundation/Foundation.h>


/**
 *  进入AppStore评分和评论
 */
@interface GoToAppStore : NSObject

+ (void)goToAppStoreWithAppID:(NSString *)appIdStr;

@end
