//
//  IsRootViewController.h
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/4/2.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsRootViewController : NSObject

/**
 *  判断是否为主视图控制器私有方法
 *
 *  @param ViewController 要判断的视图控制器
 *
 *  @return 返回判断的布尔值
 */
+ (BOOL)isRootViewControllerForViewController:(UIViewController *)ViewController;

@end
