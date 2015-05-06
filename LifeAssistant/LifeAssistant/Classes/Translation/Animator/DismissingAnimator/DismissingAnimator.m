//
//  DismissingAnimator.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/27.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "DismissingAnimator.h"
#import <pop/POP.h>

@implementation DismissingAnimator

/**
 *  描述动画的执行时间,系统给出一个切换上下文,我们根据上下文环境返回这个切换所需要的花费时间
 *
 *  @param transitionContext 过渡的上下文。
 *
 *  @return 动画时间
 */
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

/**
 *  描述动画的执行,在进行切换的时候将调用该方法,我们对于切换时的UIView的设置和动画都在这个方法中完成。
 *
 *  @param transitionContext transitionContext 过渡的上下文。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    /*
     - 在Dismiss动画中,transitionContext.containerView.subviews里面包含了
     - 之前添加进去的View哦,这点很重要
     */
    
    //首先需要得到参与切换的两个ViewController的信息，使用context的方法拿到它们的参照
    
    //获取原始控制器的View
    UIView *fromView = nil;
    //获取推出控制器的View
    UIView *toView = nil;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromView = fromVC.view;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView = toVC.view;
    
    //开启toVC的用户交互,还原正常的色调颜色模式,就是之前原始视图fromView
    toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toView.userInteractionEnabled = YES;
    
    //找到刚刚的那个用于改变透明度的blurredImageView
    __block UIImageView *blurredImageView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        
        if (imageView.layer.opacity < 1.f)
        {
            blurredImageView = imageView;
            //停止遍历
            *stop = YES;
        }
        
    }];
    
    
    //*****************改变透明度动画(基本动画类型)*********************
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    [blurredImageView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    //**************************************************************
    
    //*******************改变位置动画(基本类型)************************
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offscreenAnimation.toValue = @(-fromView.layer.position.y);
    //动画完成块
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
        //通知动画结束
        [transitionContext completeTransition:YES];
        
    }];
    [fromView.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    //**************************************************************
    
  
}

@end
