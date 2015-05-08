//
//  ToBeTranslationContentView.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/17.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TranslationContentViewDelegate <NSObject>

- (void)toTranslateTheString:(NSString *)srcString;

//可选择的, 非强制的
@optional
- (void)translationContentViewForSourceLanguageBtnClick;
- (void)translationContentViewForTargetLanguageBtnClick;
- (void)translationContentViewSwitchingBetweenLanguages;
- (void)translationContentViewForMicrophoneButtonClick;

@end

/**
 *  要翻译内容视图
 */
@interface ToBeTranslationContentView : UIView

/**
 *  源语言
 */
@property (nonatomic,strong) UIButton *sourceLanguageBtn;
/**
 *  目标语言
 */
@property (nonatomic,strong) UIButton *targetLanguageBtn;
/**
 *  切换语言
 */
@property (nonatomic,strong) UIButton *switchLanguageBtn;
/**
 *  输入要翻译的文本视图
 */
@property (nonatomic,strong) UITextView *toBeTranslationTV;
/**
 *  当前视图高度
 */
@property (nonatomic,assign) CGFloat viewHeight;

/**
 *  要翻译内容视图的代理
 */
@property (nonatomic,weak) id <TranslationContentViewDelegate>delegate;

@end
