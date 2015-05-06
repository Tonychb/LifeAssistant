//
//  JLCheckUpdate.h
//  JewelryLion
//
//  Created by zhubaoshi on 15/3/4.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

/**
 *  具体步骤如下：
 1，用 POST 方式发送请求：
 http://itunes.apple.com/search?term=你的应用程序名称&entity=software
 
 更加精准的做法是根据 app 的 id 来查找：
 http://itunes.apple.com/lookup?id=你的应用程序的ID
 #define APP_URL http://itunes.apple.com/lookup?id=你的应用程序的ID
 
 你的应用程序的ID 是 itunes connect里的 Apple ID
 
 2，从获得的 response 数据中解析需要的数据。因为从 appstore 查询得到的信息是 JSON 格式的，所以需要经过解析。解析之后得到的原始数据就是如下这个样子的：
 {
 resultCount = 1;
 results =     [
 {
 artistId = 开发者 ID;
 artistName = 开发者名称;
 price = 0;
 isGameCenterEnabled = 0;
 kind = software;
 languageCodesISO2A =             (
 EN
 );
 trackCensoredName = 审查名称;
 trackContentRating = 评级;
 trackId = 应用程序 ID;
 trackName = 应用程序名称";
 trackViewUrl = 应用程序介绍网址;
 userRatingCount = 用户评级;
 userRatingCountForCurrentVersion = 1;
 version = 版本号;
 wrapperType = software;
 }
 ];
 }
 
 然后从中取得 results 数组即可，具体代码如下所示：
 
 NSDictionary *jsonData = [dataPayload JSONValue];
 NSArray *infoArray = [jsonData objectForKey:@"results"];
 NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
 NSString *latestVersion = [releaseInfo objectForKey:@"version"];
 NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
 
 如果你拷贝 trackViewUrl 的实际地址，然后在浏览器中打开，就会打开你的应用程序在 appstore 中的介绍页面。当然我们也可以在代码中调用 safari 来打开它。
 UIApplication *application = [UIApplication sharedApplication];
 [application openURL:[NSURL URLWithString:trackViewUrl]];
 
 */

#import <Foundation/Foundation.h>

/**
 *  版本检查更新
 */
@interface JLCheckUpdate : NSObject <UIAlertViewDelegate>

+ (void)check;

@end
