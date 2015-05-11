//
//  TranslationViewController.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/15.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "TranslationViewController.h"
#import "ToBeTranslationContentView.h"
#import "DataModel.h"
#import "UINavigationBar+Awesome.h"
#import "DictionaryTableViewCell.h"
#import "DictCellFrame.h"
#import "SelectLanguagesViewController.h"
#import "PresentingAnimator.h"//定制的呈现视图动画过渡
#import "DismissingAnimator.h"//定制的解散视图动画过渡
#import "SelectLanguageView.h"

@interface TranslationViewController ()<TranslationContentViewDelegate,UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate,BDRecognizerViewDelegate,MVoiceRecognitionClientDelegate>

@property (nonatomic,strong) ToBeTranslationContentView *toBeTranslationView;//要翻译内容视图
@property (nonatomic,strong) UIImageView *logoImageView; //logo图标
@property (nonatomic,strong) UITableView *translationTableView;//翻译页面的表格视图
@property (nonatomic,strong) NSArray *languagesArray; //支持语种数组
@property (nonatomic,strong) TranslationModel *translationModel; //翻译数据模型
@property (nonatomic,strong) DictionaryModel *dictionaryModel; //词典数据模型
@property (nonatomic,strong) DictCellFrame *dictCellFrame;//词典视图框架模型
@property (nonatomic,strong) BDRecognizerViewController *recognizerViewController;//语音识别弹窗视图控件对象


@end

@implementation TranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = kViewBackGroundColor;
    
    
    //读取plist
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LanguageEncoding" ofType:@"plist"];
    _languagesArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    
    //设置翻译页面导航栏
    [self setTranslationNavBar];
    
    //添加翻译页面里的控件
    [self addTranslationVCControl];
    
    //添加Logo图标
    [self addLogo];
    
    //添加翻译页面的表格视图
    [self addTranslationTableView];
    
    //点击空白处隐藏键盘的方法
    [self addTap];
    
}

#pragma mark - 设置翻译页面导航栏
- (void)setTranslationNavBar
{
    self.navigationItem.title = @"翻译";
    
    
    //self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.tintColor = kTabBarTitleColor;
    
    // 让iOS7 导航控制器不透明
    //self.navigationController.navigationBar.translucent = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //UIBarButtonItem扩展方法,自定义导航条按钮样式
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"Classification" highLightedImageName:@"Classification" addTarget:self action:@selector(style) forControlEvents:UIControlEventTouchUpInside isLeft:YES];
    
    //隐藏导航栏
    //self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 添加翻译页面里的控件
- (void)addTranslationVCControl
{
    self.toBeTranslationView = [[ToBeTranslationContentView alloc]init];
    self.toBeTranslationView.frame = CGRectMake(0, kStatusBarAndNaviBarH, kScreenSize.width, self.toBeTranslationView.viewHeight);
    self.toBeTranslationView.delegate = self;
    self.toBeTranslationView.switchLanguageBtn.selected = YES;
    
    [self.toBeTranslationView.sourceLanguageBtn setTitle:@"中文" forState:UIControlStateNormal];
    [self.toBeTranslationView.targetLanguageBtn setTitle:@"英语" forState:UIControlStateNormal];
    [self.view addSubview:self.toBeTranslationView];
    [self.view bringSubviewToFront:self.toBeTranslationView];
}

#pragma mark - 添加Logo图标
- (void)addLogo
{
    _logoImageView = [[UIImageView alloc]init];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"lifeassistant" ofType:@"png"];
    _logoImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _logoImageView.clipsToBounds = YES;
    [self.view addSubview:_logoImageView];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(CGRectGetMaxY(self.toBeTranslationView.frame), kInterval, kTabBarHeight, kInterval));
    }];
}

#pragma mark - 添加翻译页面的表格视图
- (void)addTranslationTableView
{
    self.translationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStyleGrouped];
    self.translationTableView.hidden = YES;
    self.translationTableView.backgroundColor  = [UIColor whiteColor];
    self.translationTableView.delegate = self;
    self.translationTableView.dataSource = self;
    self.translationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.toBeTranslationView.frame) - kStatusBarAndNaviBarH)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.translationTableView.tableHeaderView = headerView;
    [self.view addSubview:self.translationTableView];
    [self.view sendSubviewToBack:self.translationTableView];
}

//#pragma mark - 添加隐藏键盘方法
////轻击：开始触摸的方法
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    MyLog(@"touchesBegan:withEvent:");
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}

#pragma mark - 点击空白处隐藏键盘的方法
- (void)addTap
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.toBeTranslationView.toBeTranslationTV resignFirstResponder];
}


#pragma mark - TranslationContentViewDelegate
#pragma mark    请求翻译和词典
- (void)toTranslateTheString:(NSString *)srcString
{
    //源语言
    NSString *fromStr = nil;
    //目标语言
    NSString *toStr = nil;
    for (NSDictionary *dict in _languagesArray)
    {
        //取出源语言和目标语言按钮对应的语种
        if ([self.toBeTranslationView.sourceLanguageBtn.titleLabel.text isEqualToString:dict[@"language"]])
        {
            fromStr = dict[@"code"];
        }
        
        if ([self.toBeTranslationView.targetLanguageBtn.titleLabel.text isEqualToString:dict[@"language"]])
        {
            toStr = dict[@"code"];
        }
    }
    
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    [paramsDict setValue:kBaiduAPIKey forKey:@"client_id"];
    if (srcString != nil && ![srcString isEqual:[NSNull null]]) {
        [paramsDict setValue:srcString forKey:@"q"];
    }
    if (fromStr != nil && ![fromStr isEqual:[NSNull null]]) {
        [paramsDict setValue:fromStr forKey:@"from"];
    }
    if (toStr != nil && ![toStr isEqual:[NSNull null]]) {
        [paramsDict setValue:toStr forKey:@"to"];
    }
    
    
    
    //请求翻译
    [HttpTool get:kBaiduTranslateAPIURL params:paramsDict success:^(id responseObj) {
        
        /*MJExtension字典和模型之间互相转换的超轻量级框架,
         objectWithKeyValues:方法通过字典来创建一个模型
         keyValues方法将模型转成字典*/
        
        self.translationModel = [TranslationModel objectWithKeyValues:responseObj];
        
        if (self.translationModel.error_msg == nil || self.translationModel.error_code == nil)
        {
            [self.translationTableView reloadData];
            self.translationTableView.hidden = NO;
            _logoImageView.hidden = YES;
            
            //******************请求词典******************
            [HttpTool get:kBaiduDictAPIURL params:@{@"client_id":kBaiduAPIKey,@"q":srcString,@"from":fromStr,@"to":toStr} success:^(id responseObj) {
                
                MyLog(@"请求词典--->%@",responseObj);
                
                self.dictionaryModel = [DictionaryModel objectWithKeyValues:responseObj];
                
                //0为成功返回，其他都为失败
                if (self.dictionaryModel.dictErrno.integerValue == 0)
                {
                    //创建词典视图框架模型
                    self.dictCellFrame = [[DictCellFrame alloc]init];
                    self.dictCellFrame.dictData = self.dictionaryModel.data;
                    [self.translationTableView reloadData];
                }
                else
                {
                    NSString *dictErrorMessage = [NSString stringWithFormat:@"错误码:%ld,\n错误信息:%@",(long)self.dictionaryModel.dictErrno.integerValue,self.dictionaryModel.dictErrmsg];
                    UIAlertView *dictErrorAlertView = [[UIAlertView alloc]initWithTitle:@"发生错误" message:dictErrorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [dictErrorAlertView show];
                }
                
            } failure:^(NSError *error) {
                
                MyLog(@"网络错误:%@",[error localizedDescription]);
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }];
            
            //*******************************************
        }
        else
        {
            NSString *zhErrorMsg = nil;
            switch (self.translationModel.error_code.integerValue)
            {
                case 52001:
                    zhErrorMsg = @"超时【请调整文本字符长度】";
                    break;
                    
                case 52002:
                    zhErrorMsg = @"翻译系统错误";
                    break;
                    
                case 52003:
                    zhErrorMsg = @"未授权的用户【请检查是否将api key输入错误】";
                    break;
                    
                case 54000:
                    zhErrorMsg = @"必填参数为空【源语言 或 目标语言 或待翻译内容 三个必填参数，请检查是否相关参数未填写完整】";
                    break;
                    
                default:
                    zhErrorMsg = @"";
                    break;
            }
            
            /*
             #if 0   //注释代码
             if ([self.translationModel.error_code isEqualToString: @"52001"])
             {
             zhErrorMsg = @"超时【请调整文本字符长度】";
             }
             else if ([self.translationModel.error_code isEqualToString: @"52002"])
             {
             zhErrorMsg = @"翻译系统错误";
             }
             else if ([self.translationModel.error_code isEqualToString: @"52003"])
             {
             zhErrorMsg = @"未授权的用户【请检查是否将api key输入错误】";
             }
             else if ([self.translationModel.error_code isEqualToString: @"54000"])
             {
             zhErrorMsg = @"必填参数为空【源语言 或 目标语言 或待翻译内容 三个必填参数，请检查是否相关参数未填写完整】";
             }
             else
             {
             zhErrorMsg = @"";
             }
             
             #endif
             */
            
            NSString *errorMessage = [NSString stringWithFormat:@"错误码:%@,\n错误信息:%@\n(%@)",self.translationModel.error_code,self.translationModel.error_msg,zhErrorMsg];
            UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"发生错误" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
        
        [self.toBeTranslationView.toBeTranslationTV resignFirstResponder];
        
        
    } failure:^(NSError *error) {
        
        MyLog(@"网络错误:%@",[error localizedDescription]);
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }];
    
}

#pragma mark    相互切换语言
- (void)translationContentViewSwitchingBetweenLanguages
{
    NSString *sourceStr = self.toBeTranslationView.targetLanguageBtn.titleLabel.text;
    NSString *targetStr = self.toBeTranslationView.sourceLanguageBtn.titleLabel.text;
    //源语言按钮
    [self.toBeTranslationView.sourceLanguageBtn setTitle:sourceStr forState:UIControlStateNormal];
    //目标语言按钮
    [self.toBeTranslationView.targetLanguageBtn setTitle:targetStr forState:UIControlStateNormal];
    
}

#pragma mark    源语言按钮点击选择更多语言
- (void)translationContentViewForSourceLanguageBtnClick
{
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:_languagesArray];
    
    [mutableArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        if ([dict[@"language"] isEqualToString:self.toBeTranslationView.targetLanguageBtn.titleLabel.text])
        {
            *stop = YES;
            [mutableArray removeObject:dict];
        }
        
    }];
    
    //差别在于，采用new的方式只能采用默认的init方法完成初始化,采用alloc的方式可以用其他定制的初始化方法
    SelectLanguagesViewController *selectLanguagesVC = [SelectLanguagesViewController new];
    
    selectLanguagesVC.selectLanguagesArray = mutableArray;
    
    __block NSInteger index;
    [mutableArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        if ([dict[@"language"] isEqualToString:self.toBeTranslationView.sourceLanguageBtn.titleLabel.text])
        {
            *stop = YES;
            index = idx;
        }
        
    }];
    selectLanguagesVC.selectLanguageIndex = index;
    
    [selectLanguagesVC returnLanguageString:^(NSString *languageStr) {
        
        //源语言按钮
        [self.toBeTranslationView.sourceLanguageBtn setTitle:languageStr forState:UIControlStateNormal];
        
    }];
    
    //设置动画过渡代理
    selectLanguagesVC.transitioningDelegate = self;
    //定制动画过渡
    selectLanguagesVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:selectLanguagesVC animated:YES completion:nil];
    
}

#pragma mark    目标语言按钮点击选择更多语言
- (void)translationContentViewForTargetLanguageBtnClick
{
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:_languagesArray];
    
    [mutableArray removeObjectAtIndex:0];
    
    [mutableArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        if ([dict[@"language"] isEqualToString:self.toBeTranslationView.sourceLanguageBtn.titleLabel.text])
        {
            *stop = YES;
            [mutableArray removeObject:dict];
        }
        
    }];
    
    __block NSInteger index;
    [mutableArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        if ([dict[@"language"] isEqualToString:self.toBeTranslationView.targetLanguageBtn.titleLabel.text])
        {
            *stop = YES;
            index = idx;
        }
        
    }];
    
    SelectLanguageView *selLanguageView = [[SelectLanguageView alloc]init];
    
    selLanguageView.selLanguageIndex = index;
    
    selLanguageView.selectLanguageArr = mutableArray;
    
    [selLanguageView showFromView:self.view];
    
    [selLanguageView returnLanguageString:^(NSString *languageStr) {
        
        //目标语言按钮
        [self.toBeTranslationView.targetLanguageBtn setTitle:languageStr forState:UIControlStateNormal];
        
    }];
}

#pragma mark   麦克风按钮点击事件
- (void)translationContentViewForMicrophoneButtonClick
{
    //创建识别控件对象,第一个参数为识别控件的在屏幕中的起始位置,识别控件会添加到当前的keyWindow 上。
    _recognizerViewController = [[BDRecognizerViewController alloc]initWithOrigin:CGPointMake(9, 128) withTheme:[BDTheme lightBlueTheme]];
    //实现协议,识别结果delegate
    _recognizerViewController.delegate = self;
    
    //设置是否全屏模式
    _recognizerViewController.enableFullScreenMode = NO;
    
    //设置语音识别弹窗参数配置类
    BDRecognizerViewParamsObject *paramsObject = [[BDRecognizerViewParamsObject alloc]init];
    
    // 开发者信息，必须修改API_KEY和SECRET_KEY为在百度开发者平台申请得到的值，否则示例不能工作
    paramsObject.apiKey = kBaiduAPIKey;
    paramsObject.secretKey = kBaiduSecretKey;
    
    // 设置是否需要语义理解，只在搜索模式有效
    paramsObject.isNeedNLU = FALSE;

    
    if ([self.toBeTranslationView.sourceLanguageBtn.titleLabel.text isEqualToString:@"中文"]) {
        
        // 设置识别语言(普通话)
        paramsObject.language = BDVoiceRecognitionLanguageChinese;
        
    } else if ([self.toBeTranslationView.sourceLanguageBtn.titleLabel.text isEqualToString:@"英语"]) {
        
        // 设置识别语言(英文)
        paramsObject.language = BDVoiceRecognitionLanguageEnglish;
        
    } else if ([self.toBeTranslationView.sourceLanguageBtn.titleLabel.text isEqualToString:@"粤语"]) {
    
        // 设置识别语言(粤语)
        paramsObject.language = BDVoiceRecognitionLanguageCantonese;
        
    }

    
    // 设置识别模式，分为搜索和输入
    paramsObject.recogPropList = @[[NSNumber numberWithInt: EVoiceRecognitionPropertySearch]];
    
    // 设置城市ID，1(标示为全国),当识别属性包含EVoiceRecognitionPropertyMap时有效,
    paramsObject.cityID = 1;
    
    // 开启联系人识别
    //    paramsObject.enableContacts = YES;
    
    // 设置显示效果，是否开启连续上屏
    paramsObject.resultShowMode = BDRecognizerResultShowModeContinuousShow;
    
    //是否禁用标点
    paramsObject.disablePuncs = FALSE;
    
    // 设置提示音开关，是否打开，默认打开
    paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordPlay;
    
    //提示语列表界面标题
    paramsObject.tipsTitle = @"支持3种识别语言";
    //提示语列表,用于提示 用户说出的话
    paramsObject.tipsList = [NSArray arrayWithObjects:@"普通话", @"粤语", @"美式英文", nil];
    //是否在第一次启动时 打开提示语列表
    // 是否在对话框启动后展示引导提示，而不启动识别，默认关闭，若开启，请确认设置提示语列表
    //paramsObject.isShowTipsOnStart = YES;
    
    // 引擎启动后3秒没检测到语音，是否在动效下方随机出现一条提示语。如果配置了提示语列表，则默认开启
    paramsObject.isShowTipAfter3sSilence = YES;
    // 未检测到语音异常时，将“取消”按钮替换成帮助按钮。在配置了提示语列表后，默认开启
    paramsObject.isShowHelpButtonWhenSilence = YES;
    // 是否需要对录音数据进行端点检测
    paramsObject.isNeedVad = NO;
    // 是否需要对录音数据进行压缩
    paramsObject.isNeedCompress = NO;
    
    //启动识别
    [_recognizerViewController startWithParams:paramsObject];
}

#pragma mark - BDRecognizerViewDelegate语音弹窗UI的委托接口
- (void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerViewController withResults:(NSArray *)aResults {
    
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
    {
        // 在非输入模式下,当 isNeedNLU = NO 时,结果是一个候选句列表,为 NSArray,
        // 元素是 NSString,例如["公园", "公元"]
        // 当 isNeedNLU = YES 时,结果类型仍为 NSArray,只有一个 NSString 元素, // 内容是 JSON 串,开发者需要自行解析,解析方法请参考语义解析文档
        NSMutableString *tmpString = [aResults objectAtIndex:0];
    
        _toBeTranslationView.textViewplaceholder.text = @"";
        _toBeTranslationView.clearButton.hidden = NO;
        _toBeTranslationView.toBeTranslationTV.text = tmpString;
        
        [self toTranslateTheString:tmpString];
    
    }
    else
    {
        //按照词粒度改错,并且返回可信度。结果是一个 NSArray,但元素仍然是 NSArray,
        // 此元素就是词语的解码和改错结果,其元素为 NSDictionary(key 为候选词,value 为可信度)
        // 输入模式下的结果为带置信度的结果，示例如下：
        //  [
        //      [
        //         {
        //             "百度" = "0.6055192947387695";
        //         },
        //         {
        //             "摆渡" = "0.3625582158565521";
        //         },
        //      ]
        //      [
        //         {
        //             "一下" = "0.7665404081344604";
        //         }
        //      ],
        //   ]

    }
    
}


#pragma mark - UITableViewDataSource
#pragma mark    表格视图有多少节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark    每节里面有多少行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.translationModel.trans_result.count > 0)
        {
            return self.translationModel.trans_result.count;
        }
        else
        {
            return 0;
        }
    }
    else if (section == 1)
    {
        if (self.dictionaryModel.data.symbols.count > 0)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

#pragma mark    每行里面创建的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *nilCell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellOne"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (self.translationModel.trans_result.count > 0)
        {
            TransResult *transResult = self.translationModel.trans_result[indexPath.row];
            cell.textLabel.text = transResult.dst;
            cell.textLabel.textColor = kTabBarTitleNormalColor;
        }
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        DictionaryTableViewCell *dictionaryCell = [tableView dequeueReusableCellWithIdentifier:[DictionaryTableViewCell ID]];
        if (dictionaryCell == nil)
        {
            dictionaryCell = [[DictionaryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DictionaryTableViewCell ID]];
            dictionaryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (self.dictionaryModel.data.symbols.count > 0)
        {
            dictionaryCell.dictCellFrame = self.dictCellFrame;
        }
        
        return dictionaryCell;
    }
    else
    {
        return nilCell;
    }
    
}

#pragma mark - UITableViewDelegate
#pragma mark    每节页眉创建的视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.translationModel.trans_result.count > 0)
        {
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
            
            UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(kInterval, 0, headerView.frame.size.width, headerView.frame.size.height)];
            [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [titleBtn setTitle:@"  译文" forState:UIControlStateNormal];
            titleBtn.titleLabel.font = kTableLabelFont;
            [titleBtn setImage:[UIImage imageNamed:@"bar"] forState:UIControlStateNormal];
            [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [headerView addSubview:titleBtn];
            
            UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleBtn.frame), kScreenSize.width, 0.5)];
            lineImageView.backgroundColor = [UIColor colorFromHexRGB:@"c9c9c9" withAlpha:1.0];
            [headerView addSubview:lineImageView];
            
            return headerView;
        }
        else
        {
            return nil;
        }
        
    }
    else if(section == 1)
    {
        if (self.dictionaryModel.data.symbols.count > 0)
        {
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
            
            UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(kInterval, 0, headerView.frame.size.width, headerView.frame.size.height)];
            [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [titleBtn setTitle:@"  词典查询(只支持中英文双语相互查询)" forState:UIControlStateNormal];
            titleBtn.titleLabel.font = kTableLabelFont;
            [titleBtn setImage:[UIImage imageNamed:@"bar"] forState:UIControlStateNormal];
            [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [headerView addSubview:titleBtn];
            
            UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleBtn.frame), kScreenSize.width, 0.5)];
            lineImageView.backgroundColor = [UIColor colorFromHexRGB:@"c9c9c9" withAlpha:1.0];
            [headerView addSubview:lineImageView];
            
            return headerView;
            
        }
        else
        {
            return nil;
        }
        
    }
    else
    {
        return nil;
    }
}

#pragma mark    每节的页眉高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.translationModel.trans_result.count > 0)
        {
            return 40;
        }
        else
        {
            return 0;
        }
        
    }
    else if (section == 1)
    {
        if (self.dictionaryModel.data.symbols.count > 0)
        {
            return 40;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
    
}

#pragma mark    每节的页脚高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000000001;
}

#pragma mark    每节里面的每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.translationModel.trans_result.count > 0)
        {
            return 50;
        }
        else
        {
            return 0;
        }
    }
    else if (indexPath.section == 1)
    {
        if (self.dictionaryModel.data.symbols.count > 0)
        {
            return self.dictCellFrame.dictCellHeight;
        }
        else
        {
            return 0;
        }
        
    }
    else
    {
        return 0;
    }
}

#pragma mark - UIScrollViewDelegate
//将要开始拖拽，手指已经放在view上并准备拖动的那一刻
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //MyLog(@"%f",offsetY);
    
    
    
    if (offsetY > 0)
    {
        if (offsetY >= 44)
        {
            [self setNavigationBarTransformProgress:1];
            
            
            
        }
        else
        {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
            
        }
        
        
        
        
    }
    else
    {
        [self setNavigationBarTransformProgress:0];
        //self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        
    }
    
}

#pragma mark - 设置UINavigationBar私有方法
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    //设置UINavigationBar的Y坐标偏移
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    //设置UINavigationBar内容透明度
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:kNavBarTitleFont,NSForegroundColorAttributeName:[UIColor colorFromHexRGB:@"ffffff" withAlpha:(1-progress)]}];
    //[self.navigationController.navigationBar lt_setContentAlpha:(1-progress)];
    
    //********要翻译内容视图平移********
    if (progress == 0)
    {
        /*
         参数说明：
         duration为动画持续的时间。
         delay为动画开始执行前等待的时间.
         options为动画执行的选项,动画的节奏控制.
         animations为动画效果的代码块。
         completion为动画执行完毕以后执行的代码块
         */
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.toBeTranslationView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.toBeTranslationView.transform = CGAffineTransformMakeTranslation(0, -((self.toBeTranslationView.viewHeight+ kStatusBarAndNaviBarH) * progress) );
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}


#pragma mark - UIViewControllerTransitioningDelegate
#pragma mark    呈现控制器的动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //采用new的方式只能采用默认的init方法完成初始化,采用alloc的方式可以用其他定制的初始化方法
    PresentingAnimator *presentingAnimator = [PresentingAnimator new];
    return presentingAnimator;
}

#pragma mark    解散控制器的动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    DismissingAnimator *dismissingAnimator = [DismissingAnimator new];
    return dismissingAnimator;
    
}

#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    //********导航栏透明的悬浮在ViewController上***********
    //    //创建透明图片
    //    UIImage *clearImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(kScreenSize.width, kStatusBarAndNaviBarH)];
    //    //    //要设置成全屏布局才能看到效果，默认就是全屏的
    //    //    self.edgesForExtendedLayout = UIRectEdgeAll;
    //    [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = clearImage;
    //    //**************************************************
    
}

#pragma mark - 视图将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //self.translationTableView.delegate = nil;
    //导航条背景颜色重置
    [self.navigationController.navigationBar lt_reset];
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
