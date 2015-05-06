//
//  MainTabBar.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/3/31.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "MainTabBar.h"

@implementation MainTabBar

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}
//
//#pragma mark - 布局子控件
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 设置所有tabbarButton的frame
//    [self setupAllTabBarButtonsFrame];
//}
//
//#pragma mark - 设置所有tabbarButton的frame
//- (void)setupAllTabBarButtonsFrame
//{
//    NSInteger index = 0;
//    
//    // 遍历所有的button
//    for (UIView *tabBarButton in self.subviews) {
//        // 如果不是UITabBarButton， 直接跳过
//        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
//        
//        // 根据索引调整位置
//        //[self setupTabBarButtonFrame:tabBarButton atIndex:index];
//        
//        // 遍历UITabBarButton中的所有子控件
//        [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
//        
//        // 索引增加
//        index++;
//    }
//}
//
////#pragma mark - 设置某个按钮的frame
////- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
////{
////    // 计算button的尺寸
////    CGFloat buttonW = self.width / (self.items.count + 1);
////    CGFloat buttonH = self.height;
////    
////    tabBarButton.width = buttonW;
////    tabBarButton.height = buttonH;
////    if (index >= 2) {
////        tabBarButton.x = buttonW * (index + 1);
////    } else {
////        tabBarButton.x = buttonW * index;
////    }
////    tabBarButton.y = 0;
////}
//#pragma mark - 设置某个按钮的文字颜色
//- (void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(NSInteger)index
//{
//    // 选中按钮的索引
//    NSInteger selectedIndex = [self.items indexOfObject:self.selectedItem];
//    
//    for (UILabel *label in tabBarButton.subviews)
//    {
//        // 说明不是个Label
//        if (![label isKindOfClass:[UILabel class]]) continue;
//        
//        // 设置字体
//        label.font = kTabBarTitleFont;
//        
//        if (selectedIndex == index)
//        {
//            // 说明这个Button选中, 设置label颜色为橙色
//            label.textColor = kTabBarTitleColor;
//        } else
//        {
//            // 说明这个Button没有选中, 设置label颜色为黑色
//            label.textColor = [UIColor lightGrayColor];
//        }
//    }
//}

@end
