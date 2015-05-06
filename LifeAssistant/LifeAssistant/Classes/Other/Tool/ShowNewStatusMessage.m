//
//  ShowNewStatusMessage.m
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/26.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

#import "ShowNewStatusMessage.h"

@implementation ShowNewStatusMessage

#pragma mark - 显示提示下拉刷新结果
+ (void)showNewStatusMessage:(NSUInteger)count messageStr:(NSString *)messageStr
{
    //自定义按钮设置基本属性
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //禁用按钮，这将导致控件忽略任何触摸事件。
    messageBtn.enabled = NO;
    //默认情况下，当按钮禁用的时候，图像会被画得深一点，设置NO可以取消设置
    messageBtn.adjustsImageWhenDisabled = NO;
    NSString *title = [NSString stringWithFormat:@"%lu %@",(unsigned long)count,messageStr];
    messageBtn.titleLabel.font = kNavBarTitleFont;
    [messageBtn setTitle:title forState:UIControlStateNormal];
    [messageBtn setTitleColor:[UIColor colorFromHexRGB:@"757575"withAlpha:1.0] forState:UIControlStateNormal];
    [messageBtn setBackgroundColor:[UIColor colorFromHexRGB:@"f3f0f0"withAlpha:0.8]];
    //按钮加载到整体的窗口上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:messageBtn];
    
    CGFloat height = kStatusBarAndNaviBarH;
    
    messageBtn.frame = CGRectMake(0, - height, kScreenSize.width, height);
    //设置透明度为0，隐藏按钮
    messageBtn.alpha = 0;
    //设置显示动画
    /*
     参数说明：
     duration为动画持续的时间。
     delay为动画开始执行前等待的时间.
     options为动画执行的选项,动画的节奏控制.
     animations为动画效果的代码块。
     completion为动画执行完毕以后执行的代码块
     */
    // 半秒时间淡出效果
    [UIView animateWithDuration:0.5 animations:^{
        
        messageBtn.alpha = 0.9;
        //移动效果,tx：X轴偏移位置，ty：Y轴偏移位置
        messageBtn.transform = CGAffineTransformTranslate(messageBtn.transform, 0, height);
        
    } completion:^(BOOL finished){
        // 停留1.0秒后弹回
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            messageBtn.transform = CGAffineTransformTranslate(messageBtn.transform, 0, -height);
            messageBtn.alpha = 0;
            
        } completion:^(BOOL finished) {
            // 动画结束移除控件
            [messageBtn removeFromSuperview];
            
        }];
        
    }];
    
}

@end
