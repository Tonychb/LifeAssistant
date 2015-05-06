//
//  UIView+Screenshot.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/28.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (Screenshot)

#pragma mark - 视图转换成图片
- (UIImage *)convertViewToImage
{
    //首先调用了UIGraphicsBeginImageContext()，最后调用的是UIGraphicsEndImageContext()，这两行代码可以理解为图形上下文的一个事物处理过程。
    UIGraphicsBeginImageContext(self.bounds.size);
    
    //drawViewHierarchyInRect:afterScreenUpdates:方法利用view层次结构并将其绘制到当前的上下文中。
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    //UIGraphicsGetImageFromCurrentImageContext()从图形上下文中获取刚刚生成的UIImage。
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
