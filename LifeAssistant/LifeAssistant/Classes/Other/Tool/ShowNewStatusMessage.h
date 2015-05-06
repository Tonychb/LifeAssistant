//
//  ShowNewStatusMessage.h
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/26.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowNewStatusMessage : NSObject

//显示提示下拉刷新结果
+ (void)showNewStatusMessage:(NSUInteger)count messageStr:(NSString *)messageStr;

@end
