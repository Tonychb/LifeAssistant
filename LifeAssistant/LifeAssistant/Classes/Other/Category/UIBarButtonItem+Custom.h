//
//  UIBarButtonItem+Custom.h
//  WeiBo
//
//  Created by Tonychb on 14-9-20.
//  Copyright (c) 2014年 Tonychb. All rights reserved.
//

//*********************自定义导航条按钮样式****************************

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

/**重写初始化方法，创建导航条按钮样式及事件的方法*/
- (id)initWithImageName:(NSString *)imageName highLightedImageName:(NSString *)hlImageName addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isLeft:(BOOL)isLeft;

/**其它类添加导航条按钮样式及事件的方法*/
+ (id)barButtonItemWithImageName:(NSString *)imageName highLightedImageName:(NSString *)hlImageName addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isLeft:(BOOL)isLeft;


@end
