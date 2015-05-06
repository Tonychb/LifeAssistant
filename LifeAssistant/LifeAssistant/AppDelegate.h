//
//  AppDelegate.h
//  LifeAssistant
//
//  Created by zhubaoshi on 15/5/5.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  网络监测
 */
@property (strong, nonatomic) Reachability *hostReachability;

@end

