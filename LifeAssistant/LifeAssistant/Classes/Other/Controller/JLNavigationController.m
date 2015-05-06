//
//  JLNavigationController.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/3/27.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "JLNavigationController.h"

@interface JLNavigationController ()

@end

@implementation JLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果现在push的不是栈顶控制器，那么久隐藏tabbar工具条
    if (self.viewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
