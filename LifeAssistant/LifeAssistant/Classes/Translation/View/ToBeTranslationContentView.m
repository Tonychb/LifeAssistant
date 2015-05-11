//
//  ToBeTranslationContentView.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/17.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "ToBeTranslationContentView.h"

@interface ToBeTranslationContentView ()<UITextViewDelegate>

@property (nonatomic,strong) UIButton *microphoneButton; //麦克风按钮

@property (nonatomic,strong) UIToolbar *textViewToolBar; //在弹出的键盘上面加一个view

@end

@implementation ToBeTranslationContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kViewBackGroundColor;
        //添加要翻译内容视图里的控件
        [self addToBeTranslationControl];
        
        if (kScreenSize.height < 568)
        {
            //监听键盘
            //键盘的frame(位置即将改变)，就会发出UIKeyboardWillChangeFrameNotification通知
            //键盘即将弹出，就会发出UIKeyboardWillShowNotification通知
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            //键盘即将隐藏，就会发出UIKeyboardWillHideNotification通知
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }

        
    }
    return self;
}

#pragma mark - 添加要翻译内容视图里的控件
- (void)addToBeTranslationControl
{
    CGFloat buttonHeight = 40;
    UIImage *switchLanguageBtnImage = [UIImage imageNamed:@"switch_normal"];
    CGFloat switchLanguageBtnWidth = switchLanguageBtnImage.size.width + 20;
    CGFloat buttonWidth = (kScreenSize.width - kInterval * 4 - switchLanguageBtnWidth) / 2;
    
    //***************源语言***************
    self.sourceLanguageBtn = [[UIButton alloc]initWithFrame:CGRectMake(kInterval, kInterval, buttonWidth, buttonHeight)];
    self.sourceLanguageBtn.layer.cornerRadius = 3.0;
    self.sourceLanguageBtn.layer.masksToBounds = YES;
    self.sourceLanguageBtn.titleLabel.font = kButtonTitleFont;
    [self.sourceLanguageBtn setBackgroundColor:kThemeColors];
    [self.sourceLanguageBtn setTitleColor:kDefaultFontColor forState:UIControlStateNormal];
    [self.sourceLanguageBtn addTarget:self action:@selector(sourceLanguageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sourceLanguageBtn];
    
    //***************切换语言***************
    self.switchLanguageBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sourceLanguageBtn.frame) + kInterval, self.sourceLanguageBtn.frame.origin.y, switchLanguageBtnWidth, buttonHeight)];
    self.switchLanguageBtn.layer.cornerRadius = 3.0;
    self.switchLanguageBtn.layer.masksToBounds = YES;
    [self.switchLanguageBtn setBackgroundColor:kThemeColors];
    [self.switchLanguageBtn setImage:switchLanguageBtnImage forState:UIControlStateNormal];
    [self.switchLanguageBtn setImage:[UIImage imageNamed:@"switch_selected"] forState:UIControlStateSelected];
    [self.switchLanguageBtn addTarget:self action:@selector(switchingBetweenLanguages) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.switchLanguageBtn];
    
    //***************目标语言***************
    self.targetLanguageBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.switchLanguageBtn.frame) + kInterval, self.sourceLanguageBtn.frame.origin.y, buttonWidth, buttonHeight)];
    self.targetLanguageBtn.layer.cornerRadius = 3.0;
    self.targetLanguageBtn.layer.masksToBounds = YES;
    self.targetLanguageBtn.titleLabel.font = kButtonTitleFont;
    [self.targetLanguageBtn setBackgroundColor:kThemeColors];
    [self.targetLanguageBtn setTitleColor:kDefaultFontColor forState:UIControlStateNormal];
    [self.targetLanguageBtn addTarget:self action:@selector(targetLanguageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.targetLanguageBtn];
    
    //***************输入要翻译的文本视图的背景视图***************
    UIView *textViewBGView = [[UIView alloc]initWithFrame:CGRectMake(kInterval, CGRectGetMaxY(self.sourceLanguageBtn.frame) + kInterval, kScreenSize.width - kInterval * 2, 100)];
    textViewBGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textViewBGView];
    //**********一次性删除文本按钮**********
    UIImage *clearButtonImage = [UIImage imageNamed:@"clearbutton"];
    CGSize clearButtonSize = clearButtonImage.size;
    self.clearButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(textViewBGView.frame) - clearButtonSize.width - 5, CGRectGetHeight(textViewBGView.frame) - clearButtonSize.height - 5, clearButtonSize.width, clearButtonSize.height)];
    [self.clearButton setImage:clearButtonImage forState:UIControlStateNormal];
    self.clearButton.hidden = YES;
    [self.clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [textViewBGView addSubview:self.clearButton];
    [textViewBGView bringSubviewToFront:self.clearButton];
    
    //***************输入要翻译的文本视图***************
    self.toBeTranslationTV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(textViewBGView.frame) - clearButtonSize.width - 5, CGRectGetHeight(textViewBGView.frame))];
    self.toBeTranslationTV.backgroundColor = [UIColor whiteColor];
    self.toBeTranslationTV.delegate = self;
    self.toBeTranslationTV.textColor = kTabBarTitleNormalColor;
    //设置字体大小
    self.toBeTranslationTV.font = kButtonTitleFont;
    //返回键的类型
    self.toBeTranslationTV.returnKeyType = UIReturnKeyDefault;
    //键盘类型
    self.toBeTranslationTV.keyboardType = UIKeyboardTypeDefault;
    //是否可以拖动
    self.toBeTranslationTV.scrollEnabled = YES;
    //显示数据类型的连接模式（如电话号码、网址、地址等）
    self.toBeTranslationTV.dataDetectorTypes = UIDataDetectorTypeAll;
    //取消首字母大写
    self.toBeTranslationTV.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textViewBGView addSubview:self.toBeTranslationTV];
    
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    NSString *placeholder = @"请输入要翻译的文字";
    CGSize placeholderSize = [placeholder sizeWithAttributes:@{NSFontAttributeName : kButtonTitleFont}];
    self.textViewplaceholder = [[UILabel alloc]initWithFrame:(CGRect){{5,self.toBeTranslationTV.frame.origin.y + 5},placeholderSize}];
    self.textViewplaceholder.text = placeholder;
    self.textViewplaceholder.font = kButtonTitleFont;
    self.textViewplaceholder.enabled = NO;//lable必须设置为不可用
    self.textViewplaceholder.backgroundColor = [UIColor clearColor];
    [textViewBGView addSubview:self.textViewplaceholder];
    
    //***************麦克风按钮***************
    UIImage *microImage = [UIImage imageNamed:@"micro_normal"];
    CGSize microButtonSize = microImage.size;
    _microphoneButton = [[UIButton alloc]initWithFrame:(CGRect){CGPointZero,microButtonSize}];
    [_microphoneButton setImage:microImage forState:UIControlStateNormal];
    [_microphoneButton addTarget:self action:@selector(microphoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    
    //***************在弹出的键盘上面加一个view***************
    self.textViewToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 44)];
    [self.textViewToolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissKeyBoard)];
    UIBarButtonItem *flexibleSpaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *microphoneButton = [[UIBarButtonItem alloc]initWithCustomView:_microphoneButton];
    UIBarButtonItem *flexibleSpace1Btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"翻译" style:UIBarButtonItemStyleDone target:self action:@selector(toTranslation)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:cancelButton,flexibleSpaceBtn,microphoneButton,flexibleSpace1Btn,doneButton,nil];
    [self.textViewToolBar setItems:buttonsArray];
    [self.toBeTranslationTV setInputAccessoryView:self.textViewToolBar];
    
    _viewHeight = CGRectGetMaxY(textViewBGView.frame) + kInterval * 2;
}

#pragma mark - 源语言按钮点击事件
- (void)sourceLanguageBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(translationContentViewForSourceLanguageBtnClick)])
    {
        [self.delegate translationContentViewForSourceLanguageBtnClick];
    }
}

#pragma mark - 目标语言按钮点击事件
- (void)targetLanguageBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(translationContentViewForTargetLanguageBtnClick)])
    {
        [self.delegate translationContentViewForTargetLanguageBtnClick];
    }
}

#pragma mark - 相互切换语言按钮点击事件
- (void)switchingBetweenLanguages
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(translationContentViewSwitchingBetweenLanguages)])
    {
        [self.delegate translationContentViewSwitchingBetweenLanguages];
    }
}

#pragma mark - 清除按钮点击事件
- (void)clearButtonClick:(UIButton *)sender
{
    self.toBeTranslationTV.text = @"";
    self.textViewplaceholder.text = @"请输入要翻译的文字";
    sender.hidden = YES;
}

#pragma mark - 麦克风按钮点击事件
- (void)microphoneButtonClick:(id)sender {
    
    if (self.toBeTranslationTV.isFirstResponder)
    {
        [self.toBeTranslationTV resignFirstResponder];
        
        if (self.toBeTranslationTV.text.length == 0)
        {
            self.textViewplaceholder.text = @"请输入要翻译的文字";
            self.clearButton.hidden = YES;
        }
        else
        {
            self.toBeTranslationTV.text = @"";
            self.textViewplaceholder.text = @"请输入要翻译的文字";
            self.clearButton.hidden = YES;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(translationContentViewForMicrophoneButtonClick)])
    {
        [self.delegate translationContentViewForMicrophoneButtonClick];
    }
    

}

#pragma mark - UIToolbar上的按钮点击事件
#pragma mark 取消按钮点击事件
- (void)dismissKeyBoard
{
    if (self.toBeTranslationTV.isFirstResponder)
    {
        [self.toBeTranslationTV resignFirstResponder];
        
        if (self.toBeTranslationTV.text.length == 0)
        {
            self.textViewplaceholder.text = @"请输入要翻译的文字";
            self.clearButton.hidden = YES;
        }
    }
}
#pragma mark 翻译按钮点击事件
- (void)toTranslation
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toTranslateTheString:)])
    {
        [self.delegate toTranslateTheString:self.toBeTranslationTV.text];
    }
    
}


#pragma mark - UITextViewDelegate
#pragma mark 将要开始编辑
//在textView获得焦点之前会调用该方法。
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //MyLog(@"textViewShouldBeginEditing:方法-->将要开始编辑,返回YES,允许进行编辑;否则，不允许编辑。。");
    return YES;
}

#pragma mark 将要结束编辑
//当textView失去焦点之前会调用该方法。
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //MyLog(@"textViewShouldEndEditing:方法-->将要结束编辑,返回YES,编辑应停止;否则，编辑应继续");
    return YES;
}

#pragma mark 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //MyLog(@"textViewDidBeginEditing:方法-->开始编辑,当textView获得焦点时要想做一些自己的处理，那么就在这里进行。");
}

#pragma mark 结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    //MyLog(@"textViewDidBeginEditing:方法-->结束编辑");
}

#pragma mark 内容将要发生改变
//每次用户通过键盘输入字符时，在字符显示在textView之前，该方法会被调用。
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //MyLog(@"textView:shouldChangeTextInRange:replacementText:方法-->内容将要发生改变,返回YES,在旧文本应由新的文本替换; 返回NO,更换操作应中止。");
    //更换UITextView的换行键为完成键
    if ([text isEqualToString:@"\n"])
    {
        
        [textView resignFirstResponder];
        
        return NO;
    }

    return YES;
}

#pragma mark 内容发生改变
//只有当用户修改了textView中的内容时，该方法才会被调用。
- (void)textViewDidChange:(UITextView *)textView
{
    //MyLog(@"textViewDidChange:方法-->内容发生改变");
    if (textView == self.toBeTranslationTV)
    {
        if (textView.text.length == 0)
        {
            self.textViewplaceholder.text = @"请输入要翻译的文字";
            self.clearButton.hidden = YES;
        }
        else
        {
            self.textViewplaceholder.text = @"";
            self.clearButton.hidden = NO;
        }
    }

    
    //    NSInteger number = [textView.text length];
    //    if (number > 130)
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于130" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //        [alert show];
    //        textView.text = [textView.text substringToIndex:130];
    //        number = 130;
    //    }
    //    _statusLabel.text = [NSString stringWithFormat:@"%ld/130",(long)number];
}

#pragma mark 交点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    //MyLog(@"textViewDidChangeSelection:方法-->交点发生改变,可以使用文本视图的选择范围属性来获取新的选择。");
}

#pragma mark 点击文本中的超链接时使用,需要与其他属性一起使用
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //MyLog(@"textView:shouldInteractWithURL:inRange:方法-->点击文本中的超链接时使用,需要与其他属性一起使用.返回YES:与URL交互应该被允许; 返回NO:互动不应该被允许。");
    return YES;
}

#pragma mark 点击文本中的附件时使用
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    //MyLog(@"textView:shouldInteractWithTextAttachment:inRange:方法-->点击文本中的附件时使用.返回YES:用文本附件互动应被允许; 返回NO:互动不应该被允许。");
    return YES;
}



#pragma mark - 键盘处理
/**
 *键盘即将弹出
 */
- (void)KeyboardWillShow:(NSNotification *)note
{
    //MyLog(@"%@",note.userInfo);
    //1.键盘弹出需要的时间
    CGFloat duration=[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //2.动画
    [UIView animateWithDuration:duration animations:^{
//        //取出键盘的高度
//        CGRect keyboardF = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        CGFloat keyboardH = keyboardF.size.height;
         self.transform = CGAffineTransformMakeTranslation(0, - 60);
    }];
}

/**
 *键盘即将隐藏
 */
- (void)KeyboardWillHide:(NSNotification *)note
{
    //1.键盘弹出需要的时间
    CGFloat duration=[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //2.动画
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}




@end
