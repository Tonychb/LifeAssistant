//
//  PresentingAnimator.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/27.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//


//实现 UIViewControllerContextTransitioning 协议。
#import "PresentingAnimator.h"
#import <pop/POP.h>
#import "UIView+Screenshot.h"
#import "SelectLanguagesViewController.h"

@implementation PresentingAnimator

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
    //首先需要得到参与切换的两个ViewController的信息，使用context的方法拿到它们的参照
    
    //获取原始控制器的View
    UIView *fromView = nil;
    //获取推出控制器的View
    UIView *toView = nil;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromView = fromVC.view;
    //UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    SelectLanguagesViewController *selectLanguagesVC = (SelectLanguagesViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView = selectLanguagesVC.view;
    
    //设置fromView色调颜色模式,变暗
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    //设置fromView用户交互为不能,让视图不能点击触发事件
    fromView.userInteractionEnabled = NO;
    
    //设置toView的frame
    toView.frame = CGRectMake(0, 0, CGRectGetWidth(transitionContext.containerView.bounds) - 104.f, CGRectGetHeight(transitionContext.containerView.bounds) - 288.f);
    //设置toView的初始的位置为在动画过渡视图的外部位置
    toView.center = CGPointMake(transitionContext.containerView.center.x, - transitionContext.containerView.center.y);
    
    //    //添加用来让背景变暗的动画效果的视图
    //    UIView *dimmingView = [[UIView alloc]initWithFrame:fromView.bounds];
    //    //dimmingView.backgroundColor = kDimmingViewBackGroundColor;
    //    dimmingView.backgroundColor = kDimmingViewBackGroundColor;
    //    //视图图层的透明度，0为完全透明
    //    dimmingView.layer.opacity = 0.0;
    
    //使用第三方库GPUImage来创建一个模糊的背景图像，并设置alpha为0，使得开始backgroundImageView是可见的。
    UIImageView *blurredImageView = [[UIImageView alloc]initWithFrame:fromView.frame];
    blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    blurredImageView.alpha = 0;
    UIImage *blurredImage = [UIImage blurryGPUImage:[fromView convertViewToImage] withBlurRadiusInPixels:3];
    blurredImageView.image = blurredImage;
    
    //将推出控制器的View和新建的变暗视图,添加到转场动画容器当中
    //[transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:blurredImageView];
    [transitionContext.containerView addSubview:toView];
    
    //**********位置动画(Spring弹簧系列)图层的Y坐标变化*************
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //让toView的Y坐标动画来到指定的值
    positionAnimation.toValue = @(transitionContext.containerView.center.y);
    //弹簧弹力
    positionAnimation.springBounciness = 10;
    //动画完成块
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
        //动画结束后记得设置这个参数,告诉transitionContext的动画已经结束
        [transitionContext completeTransition:YES];
    }];
    
    //**********************************************************
    
    //******缩放动画(Spring系列)沿着 X和Y坐标轴进行缩放的动画*********
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    //原始缩放几倍
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    //**********************************************************
    
    //*******************改变透明度动画(基本动画系列)*******************
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    //变暗视图图层透明度值变化
    opacityAnimation.toValue = @(0.9);
    
    //**************************************************************
    
    //最后把动画添加到指定的图层上，让动画开始生效
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    //    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    [blurredImageView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    selectLanguagesVC.dimissImgView = blurredImageView;
}


@end
