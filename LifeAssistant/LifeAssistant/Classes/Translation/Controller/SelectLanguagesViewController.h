//
//  SelectLanguagesViewController.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/27.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明的Block重新定义了一个名字
typedef void(^SelectLanguageBlock)(NSString *languageStr);

@interface SelectLanguagesViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *selectLanguagesArray;

@property (nonatomic,assign)NSInteger selectLanguageIndex;

//定义的一个Block属性
@property (nonatomic,copy) SelectLanguageBlock selectLanguageBlock;


- (void)returnLanguageString:(SelectLanguageBlock)block;

@property (nonatomic,strong) UIImageView *dimissImgView;

@end
