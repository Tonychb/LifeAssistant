//
//  DisposeMemoryWarning.m
//  JewelryLion
//
//  Created by zhubaoshi on 15/1/17.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import "DisposeMemoryWarning.h"

@implementation DisposeMemoryWarning

+ (void)disposeMemoryWarningWithViewController:(UIViewController *)ViewController;
{
    //即使没有显示在window上，也不会自动的将self.view释放。注意跟ios6.0之前的区分
    // Add code to clean up any of your own resources that are no longer necessary.
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
        if (ViewController.isViewLoaded && !ViewController.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            ViewController.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

@end
