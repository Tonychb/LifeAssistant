//
//  SelectLanguagesViewController.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/27.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "SelectLanguagesViewController.h"

@interface SelectLanguagesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *selectLanguagesTableView;

@property (nonatomic,strong) UIButton *dismissButton;

@property (nonatomic,assign) NSInteger currentIndex;//当前cell索引

@end

@implementation SelectLanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 8.f;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = kThemeColors;
    
    //添加解散视图控制器按钮
    [self addDismissButton];
    
    //添加选择语言的表格视图
    [self addSelectLanguagesTableView];
    
}

#pragma mark - 获取上一层的支持语言数组
- (void)setSelectLanguagesArray:(NSMutableArray *)selectLanguagesArray
{
    _selectLanguagesArray = selectLanguagesArray;
    
    [_selectLanguagesTableView reloadData];
}

#pragma mark - 获取转场动画过渡里的变暗背景图片视图
- (void)setDimissImgView:(UIImageView *)dimissImgView
{
    _dimissImgView = dimissImgView;
    
    _dimissImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimissImgViewClick:)];
    tap.numberOfTapsRequired = 1;
    [_dimissImgView addGestureRecognizer:tap];
}

#pragma mark    变暗背景图片视图点击手势事件
- (void)dimissImgViewClick:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 添加选择语言的表格视图
- (void)addSelectLanguagesTableView
{
    _selectLanguagesTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _selectLanguagesTableView.backgroundColor = kThemeColors;
    _selectLanguagesTableView.layer.cornerRadius = 8.f;
    _selectLanguagesTableView.layer.masksToBounds = YES;
    _selectLanguagesTableView.dataSource = self;
    _selectLanguagesTableView.delegate = self;
    [self.view addSubview:_selectLanguagesTableView];
    
    [_selectLanguagesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(_dismissButton.mas_top);
        make.width.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectLanguagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier  = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = kThemeColors;
        cell.tintColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == _selectLanguageIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSDictionary *languageDict = _selectLanguagesArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:languageDict[@"code"]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.textLabel.text = languageDict[@"language"];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == _selectLanguageIndex)
    {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_selectLanguageIndex inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone)
    {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    _selectLanguageIndex = indexPath.row;
    
    if (self.selectLanguageBlock != nil)
    {
        NSDictionary *languageDict = _selectLanguagesArray[indexPath.row];
        self.selectLanguageBlock(languageDict[@"language"]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - SelectLanguageBlock方法
- (void)returnLanguageString:(SelectLanguageBlock)block
{
    self.selectLanguageBlock = block;
}


#pragma mark - 添加解散视图控制器按钮
- (void)addDismissButton
{
    /*
     参数说明:
     第一个参数:指定约束左边的视图view1
     第二个参数:指定view1的属性attr1，具体属性见文末。
     第三个参数:指定左右两边的视图的关系relation，具体关系见文末。
     第四个参数:指定约束右边的视图view2
     第五个参数:指定view2的属性attr2，具体属性见文末。
     第六个参数:指定一个与view2属性相乘的乘数multiplier
     第七个参数:指定一个与view2属性相加的浮点数constant
     
     附视图的属性和关系的值:
     typedef NS_ENUM(NSInteger, NSLayoutRelation) {
     NSLayoutRelationLessThanOrEqual = -1,          //小于等于
     NSLayoutRelationEqual = 0,                     //等于
     NSLayoutRelationGreaterThanOrEqual = 1,        //大于等于
     };
     typedef NS_ENUM(NSInteger, NSLayoutAttribute) {
     NSLayoutAttributeLeft = 1,                     //左侧
     NSLayoutAttributeRight,                        //右侧
     NSLayoutAttributeTop,                          //上方
     NSLayoutAttributeBottom,                       //下方
     NSLayoutAttributeLeading,                      //首部
     NSLayoutAttributeTrailing,                     //尾部
     NSLayoutAttributeWidth,                        //宽度
     NSLayoutAttributeHeight,                       //高度
     NSLayoutAttributeCenterX,                      //X轴中心
     NSLayoutAttributeCenterY,                      //Y轴中心
     NSLayoutAttributeBaseline,                     //文本底标线
     
     NSLayoutAttributeNotAnAttribute = 0            //没有属性
     };
     
     格式的字符串:
     功能　　　　　　　　表达式
     
     水平方向  　　　　　　  H:
     
     垂直方向  　　　　　　  V:
     
     Views　　　　　　　　 [view]
     
     SuperView　　　　　　|
     
     关系　　　　　　　　　>=,==,<=
     
     空间,间隙　　　　　　　-
     
     优先级　　　　　　　　@value
     
     */
    /*将使用AutoLayout的方式来布局
     如果是从代码层面开始使用Autolayout,需要对使用的View的 translatesAutoresizingMaskIntoConstraints 的属性设置为NO.
     即可开始通过代码添加Constraint,否则View还是会按照以往的autoresizingMask进行计算.
     */
    
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.layer.cornerRadius = 8.0f;
    _dismissButton.layer.masksToBounds = YES;
    //dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    _dismissButton.backgroundColor = kThemeColors;
    [_dismissButton setTitle:@"取     消" forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dismissButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dismissButton];
    
    [_dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
}

#pragma mark    解散视图控制器按钮点击事件
- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
