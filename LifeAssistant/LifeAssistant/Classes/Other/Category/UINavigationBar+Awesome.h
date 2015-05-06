//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  动态改变UINavigationBar外观:改变背景颜色,制作导航栏滚动一起滚动视图
 */
@interface UINavigationBar (Awesome)

/**
 *  设置UINavigationBar背景颜色
 *
 *  @param backgroundColor 要设置的颜色
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置UINavigationBar内容透明度
 *
 *  @param alpha 要设置的透明度
 */
- (void)lt_setContentAlpha:(CGFloat)alpha;

/**
 *  设置UINavigationBar的偏移
 *
 *  @param translationY 要偏移的Y坐标
 */
- (void)lt_setTranslationY:(CGFloat)translationY;

/**
 *  UINavigationBar重置方法：通常在viewWillDisappear,调用此方法
 */
- (void)lt_reset;
@end
