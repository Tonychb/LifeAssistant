//
//  UIColor+custom.h
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/1.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (custom)
/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString withAlpha:(CGFloat)alpha;



//生成随机颜色
+ (UIColor *)randomColor;

@end
