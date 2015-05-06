//
//  MainTabBarController.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/3/31.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"
#import "JLNavigationController.h"
#import "TranslationViewController.h"
#import "SettingsViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //添加子控制器
    [self addSubViewController];
}

#pragma mark - 添加子控制器
- (void)addSubViewController
{
    //翻译首页,自定义添加一个子控制器方法
    TranslationViewController *translationVC = [[TranslationViewController alloc]init];
    [self addOneChildVc:translationVC title:@"翻译" imageName:@"global_normal" selectedImageName:@"global_selected" ];
    
    //设置页面,自定义添加一个子控制器方法
    SettingsViewController *settingsVC = [[SettingsViewController alloc]init];
    [self addOneChildVc:settingsVC title:@"设置" imageName:@"config_normal" selectedImageName:@"config_selected"];
    
    //调整tabbar
    MainTabBar *mainTabBar = [[MainTabBar alloc]init];
    //更换系统自带的tabbar
    [self setValue:mainTabBar forKeyPath:@"tabBar"];
    
    //改变UITabBar的背景色
    //海水蓝：58c5c7,深蓝：2e3192,浅蓝：00aeef,淡蓝：6dcff6
    [self.tabBar setBarTintColor:kThemeColors];
    
    self.delegate = self;
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */
-(void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置标题
    childVc.tabBarItem.title = title;
    //设置图标
    UIImage *normalImage = [UIImage imageNamed:imageName];
    //设置选中时的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    //设置tabBarItem普通状态下文字的颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabBarTitleNormalColor,NSFontAttributeName:kTabBarTitleFont} forState:UIControlStateNormal];
    
    //设置tabBarItem选择状态下文字的颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabBarTitleSelectedColor,NSFontAttributeName:kTabBarTitleFont} forState:UIControlStateSelected];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
    {
        // 声明这张图片用原图(别渲染)
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    childVc.tabBarItem.image = normalImage;
    childVc.tabBarItem.selectedImage = selectedImage;
    
    
    //添加子控制器到tabbar,自定义导航栏
    JLNavigationController *nav = [[JLNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    if (self.selectedIndex == 2)
//    {
//        UINavigationController *nav = (UINavigationController *)viewController;
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        [nav pushViewController:loginVC animated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
