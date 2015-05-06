//
//  JLCheckUpdate.m
//  JewelryLion
//
//  Created by zhubaoshi on 15/3/4.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import "JLCheckUpdate.h"

@interface JLCheckUpdate ()

//获取AppStore上最新的版本号
@property (nonatomic,copy) NSString *updateVersion;
//获取AppStore上的应用程序网址
@property (nonatomic,copy) NSString *trackViewURL;
//获取应用程序名称
@property (nonatomic,copy) NSString *appName;
//取得本地版本号
@property (nonatomic,copy) NSString *localVersion;

@property (nonatomic,strong) UIAlertView *checkUpdateAlertView;


@end

@implementation JLCheckUpdate

#pragma mark - 得到本地版本
- (NSString *)getLocalVer
{
    //版本号在info.plist中的key值:CFBundleShortVersionString对应@"version"字段,真正版本号；key值:CFBundleVersion对应@“BundleVersion”字段,程序内部调试的版本号
    NSString *key = @"CFBundleShortVersionString";
    
    //从info.plist中取出当前版本号:1.0
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    return currentVersion;
}

#pragma mark - 检查更新实例化
+ (void)check
{
    JLCheckUpdate *checkInst = [[JLCheckUpdate alloc]init];
    [checkInst start];
}

- (void)start
{
    //POST方式发送请求,从AppStore查询得到的应用程序信息
    [HttpTool post:nil params:nil success:^(id responseObj) {
        
        MyLog(@"从AppStore查询得到的应用程序信息:%@",responseObj);
        /*results是数组;
         results =    [
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
         */
        if ([responseObj[@"resultCount"] integerValue] != 0)
        {
            NSArray *infoArray = [responseObj objectForKey:@"results"];
            
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            //获取AppStore上最新的版本号
            self.updateVersion = [releaseInfo objectForKey:@"version"];
            //获取AppStore上的应用程序网址
            self.trackViewURL = [releaseInfo objectForKey:@"trackViewUrl"];
            //获取应用程序名称
            self.appName = [releaseInfo objectForKey:@"trackName"];
            //取得本地版本号
            self.localVersion = [self getLocalVer];
            
            NSUInteger updateVersionNumber = [self.updateVersion integerValue];
            NSUInteger localVersionNumber = [self.localVersion integerValue];
            
            NSString *titleStr = [NSString stringWithFormat:@"检查更新: %@",self.appName];
            NSString *messageStr = [NSString stringWithFormat:@"发现新版本:(%@),是否升级?",self.updateVersion];
            
            if (updateVersionNumber > localVersionNumber)
            {
                self.checkUpdateAlertView = [[UIAlertView alloc]initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
                [self.checkUpdateAlertView show];
            }
            else
            {
                self.checkUpdateAlertView = [[UIAlertView alloc]initWithTitle:titleStr message:@"已经升级到最新版本了!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [self.checkUpdateAlertView show];
            }
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"从AppStore查询不到该应用程序信息,请确认是否已经发布到AppStore上了!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } failure:^(NSError *error) {
        UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"网络错误提示" message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.checkUpdateAlertView)
    {
        if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewURL]];
        }
    }

}



@end
