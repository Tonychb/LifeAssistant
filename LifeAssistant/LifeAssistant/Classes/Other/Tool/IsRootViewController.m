//
//  IsRootViewController.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/4/2.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "IsRootViewController.h"

@implementation IsRootViewController

+ (BOOL)isRootViewControllerForViewController:(UIViewController *)viewController
{
    return (viewController == viewController.navigationController.viewControllers.firstObject);
}

@end
