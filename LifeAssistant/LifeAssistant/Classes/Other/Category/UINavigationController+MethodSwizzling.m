//
//  UINavigationController+MethodSwizzling.m
//  iOS7-NavigationController-Sample
//
//  Created by 魏哲 on 14-5-16.
//
//

#import "UINavigationController+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation UINavigationController (MethodSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            Method originMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
            Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzling_pushViewController:animated:));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)swizzling_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果我们在 pushViewController 的动画过程中触发滑动返回，会导致闪退，处理方式也很简单，在 push 之后禁用 interactivePopGestureRecognizer
    self.interactivePopGestureRecognizer.enabled = NO;
    
    [self swizzling_pushViewController:viewController animated:animated];
}

@end
