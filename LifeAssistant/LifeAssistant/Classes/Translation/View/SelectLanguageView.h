//
//  SelectLanguageView.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/29.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectLanguageViewBlock)(NSString *languageStr);


@interface SelectLanguageView : UIView

@property (nonatomic,strong)NSMutableArray *selectLanguageArr;

@property (nonatomic,assign)NSInteger selLanguageIndex;

@property (nonatomic,copy) SelectLanguageViewBlock selectLanguageViewBlock;

- (void)returnLanguageString:(SelectLanguageViewBlock)block;

- (void)showFromView:(UIView *)fromView;

@end
