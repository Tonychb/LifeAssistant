//
//  AppDelegate.m
//  LifeAssistant
//
//  Created by zhubaoshi on 15/5/5.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 在app开始运行时会调用里面的方法。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //*****************设置全局的导航栏和状态栏字体样式************************
    [[UINavigationBar appearance] setBarTintColor:kThemeColors];
    [[UINavigationBar appearance] setTintColor:kNavBarTitleColor];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName:kNavBarTitleFont,NSForegroundColorAttributeName:kNavBarTitleColor}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //*************开启网络状况的监听**************
    //    self.hostReachability = [Reachability reachabilityWithHostname:kAPIStoreBaseURL];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hostReachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //    //开始监听,会启动一个run loop
    //    [self.hostReachability startNotifier];
    //    //处理网络连接改变后的情况
    //    //[self updateInterfaceWithReachability:self.hostReachability];
    
    
    
    //**************根据版本号判断是否第一次使用该版本进入相应界面***************
    //版本号在info.plist中的key值:CFBundleShortVersionString对应@"version"字段,真正版本号；key值:CFBundleVersion对应@“BundleVersion”字段,程序内部调试的版本号
    //版本号在info.plist中的key值:CFBundleVersion
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    //从info.plist中取出当前版本号:1.0
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //删除沙盒中某一项数据
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    
    //从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //判断是否为第一次使用该版本，如果是就进入新特性展示，否则直接进入主界面
    if ([currentVersion isEqualToString:saveVersion])
    {
        MyLog(@"使用过的版本");
        //显示状态栏
        application.statusBarHidden = NO;
        
        //***********主界面***********
        self.window.rootViewController = [[MainTabBarController alloc]init];
    }
    else
    {
        
        //***********新特性界面***********
        //将新的版本号写入到沙盒中
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        //立即同步，即时写入
        [[NSUserDefaults standardUserDefaults]synchronize];
        MyLog(@"第一次使用该版本");
        //第一次使用该版本就进入新特性界面
        
        self.window.rootViewController = [[MainTabBarController alloc]init];
    }
    //********************************************************************
    
    [self.window makeKeyAndVisible];
    
    //***************注册推送通知(注意iOS8注册方法发生了变化)******************
#ifdef __IPHONE_8_0 //这里主要是针对iOS 8.0,相应的8.1,8.2等版本各程序员可自行发挥，如果苹果以后推出更高版本还不会使用这个注册方式就不得而知了……
    //检查一个对象是否支持一个方法
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        
        //推送的形式：标记，声音，提示警告
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
    else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
#else
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
    //********************************************************************
    application.applicationIconBadgeNumber = 0;
    
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif


#pragma mark 注册推送通知之后
//在此接收设备令牌,获取device token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //注册成功，将deviceToken保存到应用服务器数据库中
    
    // [self addDeviceToken:deviceToken];
    MyLog(@"device token:--->%@",deviceToken);
    //将deviceToken转换成字符串，以便后续使用
    MyLog(@"将deviceToken转换成字符串,deviceToken description:--->%@",[deviceToken description]);
    
}

#pragma mark 获取device token失败后
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    MyLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error.localizedDescription);
    
    //[self addDeviceToken:nil];
}

#pragma mark 接收到推送通知之后
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //程序角标数字
    application.applicationIconBadgeNumber = 0;
    
    // 处理推送消息
    MyLog(@"receiveRemoteNotification,userInfo is %@",userInfo);
    
    MyLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    MyLog(@"自定义参数:%@",[[userInfo objectForKey:@"userinfo"] objectForKey:@"name"]);

}


//#pragma mark - 私有方法
///**
// *  添加设备令牌到服务器端
// *
// *  @param deviceToken 设备令牌
// */
//-(void)addDeviceToken:(NSData *)deviceToken{
////  将deviceToken转换成字符串，以便后续使用
//    NSString *token = [deviceToken description];
//    NSString *key = @"DeviceToken";
//    NSData *oldToken= [[NSUserDefaults standardUserDefaults]objectForKey:key];
//    //如果偏好设置中的已存储设备令牌和新获取的令牌不同则存储新令牌并且发送给服务器端
//    if (![oldToken isEqualToData:deviceToken]) {
//        [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:key];
//        [self sendDeviceTokenWidthOldDeviceToken:oldToken newDeviceToken:deviceToken];
//    }
//}
//
//-(void)sendDeviceTokenWidthOldDeviceToken:(NSData *)oldToken newDeviceToken:(NSData *)newToken{
//    //注意一定确保真机可以正常访问下面的地址
//    NSString *urlStr=@"http://192.168.1.101/RegisterDeviceToken.aspx";
//    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0];
//    [requestM setHTTPMethod:@"POST"];
//    NSString *bodyStr=[NSString stringWithFormat:@"oldToken=%@&newToken=%@",oldToken,newToken];
//    NSData *body=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//    [requestM setHTTPBody:body];
//    NSURLSession *session=[NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask= [session dataTaskWithRequest:requestM completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"Send failure,error is :%@",error.localizedDescription);
//        }else{
//            NSLog(@"Send Success!");
//        }
//
//    }];
//    [dataTask resume];
//}


#pragma mark - 这个方法可以禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - 将进入后台
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    /*
     程序将要失去Active状态时调用，比如按下Home键或有电话信息进来。对应applicationWillEnterForeground（将进入前台），这个方法用来
     
     暂停正在执行的任务；
     禁止计时器；
     减少OpenGL ES帧率；
     若为游戏应暂停游戏；
     */
    
    application.applicationIconBadgeNumber = 0;
}

#pragma mark - 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    /*
     程序已经进入后台时调用，对应applicationDidBecomeActive（已经变成前台），这个方法用来
     
     释放共享资源；
     保存用户数据（写到硬盘）；
     作废计时器；
     保存足够的程序状态以便下次恢复；
     */
}

#pragma mark - 将进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //程序即将进去前台时调用，对应applicationWillResignActive（将进入后台）。这个方法用来撤销applicationWillResignActive中做的改变。
    
    application.applicationIconBadgeNumber = 0;
}

#pragma mark - 已经进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //程序已经变为Active（前台）时调用。对应applicationDidEnterBackground（已经进入后台）。若程序之前在后台，最后在此方法内刷新用户界面。
}

#pragma mark -  应用程序将终止
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //程序即将退出时调用。记得保存数据，如applicationDidEnterBackground方法一样。
}

@end
