//
//  DisposeMemoryWarning.h
//  JewelryLion
//
//  Created by zhubaoshi on 15/1/17.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DisposeMemoryWarning : NSObject

//处理内存警告
+ (void)disposeMemoryWarningWithViewController:(UIViewController *)ViewController;

@end
