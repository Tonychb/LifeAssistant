//
//  GoToAppStore.m
//  JewelryLion
//
//  Created by zhubaoshi on 15/3/9.
//  Copyright (c) 2015年 zhubaoshi. All rights reserved.
//

#import "GoToAppStore.h"

@interface GoToAppStore ()

@end

@implementation GoToAppStore

+ (void)goToAppStoreWithAppID:(NSString *)appIdStr
{
    NSString *evaluateString = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",appIdStr];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateString]];
}


@end
