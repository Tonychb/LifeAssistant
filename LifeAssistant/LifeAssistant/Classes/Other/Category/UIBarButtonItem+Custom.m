//
//  UIBarButtonItem+Custom.m
//  WeiBo
//
//  Created by Tonychb on 14-9-20.
//  Copyright (c) 2014年 Tonychb. All rights reserved.
//

//*********************自定义导航条按钮样式****************************

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

#pragma mark - 按钮样式设计及事件处理初始化方法
//重写初始化方法，创建导航条按钮样式及事件的方法
- (id)initWithImageName:(NSString *)imageName highLightedImageName:(NSString *)hlImageName addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isLeft:(BOOL)isLeft
{
    // 创建一个普通按钮并设置按钮样式
    UIButton *button = [[UIButton alloc]init];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hlImageName] forState:UIControlStateHighlighted];
    CGSize buttonSize = image.size;
    button.frame = (CGRect){CGPointZero,buttonSize};
    if (isLeft)
    {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -kInterval, 0, kInterval)];
    }
    else
    {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, kInterval, 0, -kInterval)];
    }
    //设置按钮事件处理
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    //将BarButtonItem初始化为上述按钮样式
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

#pragma mark - 按钮样式设计及事件处理类方法
//其它类添加导航条按钮样式及事件的方法
+ (id)barButtonItemWithImageName:(NSString *)imageName highLightedImageName:(NSString *)hlImageName addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isLeft:(BOOL)isLeft
{
    return [[self alloc]initWithImageName:imageName highLightedImageName:hlImageName addTarget:target action:action forControlEvents:controlEvents isLeft:isLeft];
}

@end
