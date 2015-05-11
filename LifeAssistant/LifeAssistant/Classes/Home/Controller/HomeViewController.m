//
//  HomeViewController.m
//  LifeAssistant
//
//  Created by zhubaoshi on 15/5/11.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeItem.h"
#import "POP.h"

@interface HomeViewController ()

@property (nonatomic,strong) UIImageView *backGroundImageView;
@property (nonatomic,strong) HomeItem *translationItem;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kViewBackGroundColor;
    
    [self addBackGroundImageView];
    
    [self addHomeItem];

    
}

- (void)addBackGroundImageView {

    _backGroundImageView = [[UIImageView alloc]init];
    _backGroundImageView.frame = CGRectMake(0, 0, kScreenSize.width - 140, kScreenSize.width - 140);
    _backGroundImageView.center = self.view.center;
    //_backGroundImageView.backgroundColor = [UIColor lightGrayColor];
    //_backGroundImageView.userInteractionEnabled = YES;
    _backGroundImageView.image = [UIImage imageNamed:@"lifeassistant_1"];
    _backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_backGroundImageView];
    [self.view sendSubviewToBack:_backGroundImageView];
    
}

- (void)addHomeItem {
    
    _translationItem = [[HomeItem alloc]init];
    _translationItem.frame = CGRectMake(0, 0, 55, 55);
    _translationItem.center = CGPointMake(kInterval + 55 / 2, self.view.center.y);
    _translationItem.layer.cornerRadius = 55 / 2;
    _translationItem.layer.masksToBounds = YES;
    _translationItem.enabled = NO;
    _translationItem.backgroundColor = kThemeColors;
    [_translationItem setImage:[UIImage imageNamed:@"global_selected"] forState:UIControlStateNormal];
    [_translationItem setTitle:@"翻译" forState:UIControlStateNormal];
    [_translationItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_translationItem];
    

    
    CGRect boundingRect = CGRectMake(0, -125, kScreenSize.width - 70, kScreenSize.width - 70);
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    //orbit.rotationMode = kCAAnimationRotateAuto;
    //orbit.rotationMode = nil;
    [_translationItem.layer addAnimation:orbit forKey:@"orbit"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
