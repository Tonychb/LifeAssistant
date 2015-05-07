//
//  SettingsViewController.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/16.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic,strong) UISwitch *pushNotificationSwitch;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kViewBackGroundColor;
    
    self.navigationItem.title = @"设置";
    
    //添加推送通知开关
    [self addPushNotificationSwitch];
}

#pragma mark - 添加开关按钮
- (void)addPushNotificationSwitch
{
    UILabel *title = [[UILabel alloc]init];
    title.text = @"推送通知";
    [self.view addSubview:title];
    
    _pushNotificationSwitch = [[UISwitch alloc]init];
    // 在ios7以上 中无效果
    _pushNotificationSwitch.onImage = [UIImage imageNamed:@"auto"];
    _pushNotificationSwitch.offImage = [UIImage imageNamed:@"ara"];
    //开时的背景颜色
    _pushNotificationSwitch.onTintColor = kThemeColors;
    //边框颜色
    //_pushNotificationSwitch.tintColor = [UIColor yellowColor];
    //开关的圆按钮颜色
    _pushNotificationSwitch.thumbTintColor = [UIColor whiteColor];
    [self.view addSubview:_pushNotificationSwitch];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left).with.offset(80);
        make.right.equalTo(_pushNotificationSwitch.mas_left).with.offset(-kInterval);
        make.height.equalTo(_pushNotificationSwitch);
        make.width.mas_equalTo(@80);
    }];
    [_pushNotificationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.equalTo(title.mas_right).with.offset(kInterval);
        //make.right.equalTo(self.view.mas_right).with.offset(-padding);
        //make.height.mas_equalTo(@150);
        //make.width.equalTo(title);
    }];
    
    [_pushNotificationSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];

    
#ifdef  __IPHONE_8_0
    //检查一个对象是否支持一个方法
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        if ([[UIApplication sharedApplication]isRegisteredForRemoteNotifications])
        {
            [_pushNotificationSwitch setOn:YES];
        }
        else
        {
            [_pushNotificationSwitch setOn:NO];
        }

    }
    else
    {
        if ([[UIApplication sharedApplication]enabledRemoteNotificationTypes] ==  UIRemoteNotificationTypeNone)
        {
            [_pushNotificationSwitch setOn:NO];
        }
        else
        {
            [_pushNotificationSwitch setOn:YES];
        }

    }
    
#else

    if ([[UIApplication sharedApplication]enabledRemoteNotificationTypes] ==  UIRemoteNotificationTypeNone)
    {
        [_pushNotificationSwitch setOn:NO];
    }
    else
    {
        [_pushNotificationSwitch setOn:YES];
    }
    
#endif

}


- (void) switchValueChanged:(id)sender
{
    UISwitch* switchControl = (UISwitch*)sender;
    if(switchControl == _pushNotificationSwitch)
    {
        BOOL switchStatus = switchControl.on;
        [switchControl setOn:switchStatus animated:YES];
        if (switchStatus)
        {
            //***************注册推送通知(注意iOS8注册方法发生了变化)******************
#ifdef __IPHONE_8_0 //这里主要是针对iOS 8.0,相应的8.1,8.2等版本各程序员可自行发挥，如果苹果以后推出更高版本还不会使用这个注册方式就不得而知了……
            //检查一个对象是否支持一个方法
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
            {
                
                //推送的形式：标记，声音，提示警告
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
                
            }
            else
            {
                UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
            }
#else
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
        }
        else
        {
            [[UIApplication sharedApplication]unregisterForRemoteNotifications];
        }
    }
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
