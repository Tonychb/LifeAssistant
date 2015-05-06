//
//  TAAnimatedDotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation TAAnimatedDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (void)initialization
{
    self.backgroundColor    = [UIColor colorWithWhite:0.667 alpha:0.4];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
//    self.layer.borderColor  = [UIColor lightGrayColor].CGColor;
//    self.layer.borderWidth  = 1;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


- (void)animateToActiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        //self.backgroundColor = kTabBarTitleColor;
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)animateToDeactiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.4];
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
