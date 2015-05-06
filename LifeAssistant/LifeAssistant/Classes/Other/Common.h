//
//  Common.h
//  WeiBo
//
//  Created by Tonychb on 14-9-18.
//  Copyright (c) 2014年 Tonychb. All rights reserved.
//


//公共头文件,创建全局宏，抽取常用代码及变量的统一定义与修改

//如果未定义common.h头文件,主要是为了防止多个重名的头文件存在
#ifndef __COMMON_H__
//则定义
#define __COMMON_H__

//***********************网络请求地址*************************

//****服务商：百度API*******
//翻译接口地址
#define kBaiduTranslateAPIURL   @"http://openapi.baidu.com/public/2.0/bmt/translate"

//词典接口地址
#define kBaiduDictAPIURL  @"http://openapi.baidu.com/public/2.0/translate/dict/simple"

//***********************应用参数和第三方key*************************

//****服务商：百度开放服务平台*******
//应用程序的ID,AppID
#define kBaiduAppID         @"5775952"

//百度授权APIKey
#define kBaiduAPIKey        @"YGx2QNjBU4FYgaWKn1NjeMVp"

//百度SecretKey
#define kBaiduSecretKey     @"YjQs0GbtnwGwKfXrgV3OobukGCEiK4qF"

////appstore提供的api接口进行查询更新,你的应用程序的ID 是 itunes connect里的 Apple ID
//#define kApp_URL    [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppID]





//************************常用代码及变量******************************

#define kScreenSize [UIScreen mainScreen].bounds.size   //当前屏幕宽高

#define isIPhone5 (kScreenSize.height == 568)   //判断是否为iphone5的宏

/*
 获取iphone的系统信息使用[UIDevice currentDevice],信息如下：
 
 [[UIDevice currentDevice] systemName]：系统名称，如iPhone OS
 [[UIDevice currentDevice] systemVersion]：系统版本，如4.2.1
 [[UIDevice currentDevice] model]：The model of the device，如iPhone或者iPod touch
 [[UIDevice currentDevice] uniqueIdentifier]：设备的惟一标识号，deviceID
 [[UIDevice currentDevice] name]：设备的名称，如 张三的iPhone
 [[UIDevice currentDevice] localizedModel]：The model of the device as a localized string，类似model
 */
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f

#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f


// 用MyLog替代NSLog，调试时输出日志，正式发布时自动取消日志输出代码
#ifdef DEBUG

#define MyLog(...) NSLog(__VA_ARGS__)   //调试状态

#else

#define MyLog(...)  //打包发布

#endif


//注释代码
//#if 0
//#endif

//*******************我的应用程序切换*******************
#define kActivateGPSOnStartUp       YES //激活GPS启动
#define kRegistrationRequired       YES //需要注册
#define kLoginRequired              NO  //需要登录
#define kShowLoginAfterRegistration YES //显示登录注册后
#define kInstallCrashHandler        YES //安装处理程序崩溃

//*******************该用于存储数据的键*******************
#define kRegistered                 @"kRegistered"      //注册
#define kAuthenticated              @"kAuthenticated"   //身份验证
#define kFirstLaunch                @"kFirstLaunch"     //首先启动
#define kVibrate                    @"kVibrate"         //颤动

//************************控件样式设置************************
//****************颜色****************
//#define kThemeColors                [UIColor colorFromHexRGB:@"00aeef" withAlpha:1] //主题颜色
#define kThemeColors                [UIColor colorFromHexRGB:@"3498db" withAlpha:1] //主题颜色
#define kDefaultFontColor           [UIColor whiteColor]//默认字体颜色
#define kViewBackGroundColor        [UIColor colorFromHexRGB:@"eeeeee" withAlpha:1] //页面背景色
#define kNavBarTitleColor           kDefaultFontColor //导航栏字体颜色
#define kTabBarTitleNormalColor     [UIColor colorFromHexRGB:@"1b1b1b" withAlpha:1] //选项卡标题字体正常时颜色
#define kTabBarTitleSelectedColor   kDefaultFontColor //选项卡标题字体选中时颜色
#define kDimmingViewBackGroundColor        [UIColor colorFromHexRGB:@"545454" withAlpha:1] //变暗视图背景颜色
//****************字体大小****************
#define kNavBarTitleFont            [UIFont systemFontOfSize:17] //导航栏标题字体大小
#define kButtonTitleFont            [UIFont systemFontOfSize:17] //普通按钮标题字体大小
#define kTableHeadTitleFont         [UIFont systemFontOfSize:17] //表格头部标题字体大小
#define kTableLabelFont             [UIFont systemFontOfSize:14] //表格标签字体大小
#define kTabBarTitleFont            [UIFont systemFontOfSize:10] //选项卡标题字体大小
//**************************
#define kStatusBarAndNaviBarH       64 //状态栏加上导航栏的高度
#define kTabBarHeight               49 //标签栏高度
#define kInterval                   10 //控件相对边缘的间距
//**********************************************************
#endif  // __COMMON_H__