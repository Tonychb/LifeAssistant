//
//  SelectLanguageView.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/29.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "SelectLanguageView.h"
#import <pop/POP.h>
#import "UIView+Screenshot.h"

@interface SelectLanguageView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *selLanguageContentView;//内容视图

@property (nonatomic,strong) UITableView *selectLanguageTableView;//表格视图

@property (nonatomic,strong) UIImageView *coverImageView;//掩盖视图

@property (nonatomic,strong) UIButton *dismissButton;//关闭视图按钮

@end

@implementation SelectLanguageView

#pragma mark - 初始化方法
//init方法会调用该方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.coverImageView = [[UIImageView alloc]init];
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.coverImageView.alpha = 0;
        self.coverImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverImageViewClick)];
        [self.coverImageView addGestureRecognizer:tap];
        [self addSubview:self.coverImageView];
        
        self.selLanguageContentView = [[UIView alloc]init];
        self.selLanguageContentView.backgroundColor = [UIColor colorFromHexRGB:@"3498db" withAlpha:0];
        self.selLanguageContentView.userInteractionEnabled = YES;
        self.selLanguageContentView.layer.cornerRadius = 8.f;
        self.selLanguageContentView.layer.masksToBounds = YES;
        [self addSubview:self.selLanguageContentView];
        
        self.dismissButton = [[UIButton alloc]init];
        self.dismissButton.clipsToBounds = NO;
        [self.selLanguageContentView addSubview:self.dismissButton];
        [self.selLanguageContentView bringSubviewToFront:self.dismissButton];
        
        self.selectLanguageTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.selectLanguageTableView.backgroundColor = kThemeColors;
        self.selectLanguageTableView.delegate = self;
        self.selectLanguageTableView.dataSource = self;
        self.selectLanguageTableView.layer.cornerRadius = 8.f;
        self.selectLanguageTableView.layer.masksToBounds = YES;
        [self.selLanguageContentView addSubview:self.selectLanguageTableView];
        [self.selLanguageContentView sendSubviewToBack:self.selectLanguageTableView];
        
    }
    return self;
}

#pragma mark - 获取上一层的支持语言数组
- (void)setSelectLanguageArr:(NSMutableArray *)selectLanguageArr
{
    _selectLanguageArr = selectLanguageArr;
    
    [self.selectLanguageTableView reloadData];
}

#pragma mark - 内部按钮事件方法
- (void)coverImageViewClick
{
    [self.selLanguageContentView.layer pop_removeAllAnimations];
    [self.coverImageView.layer pop_removeAllAnimations];
    
    //**********(Spring弹簧系列)*************
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //弹簧弹力
    springAnimation.springBounciness = 10;
    //速度
    springAnimation.springSpeed = 10;
    [self.selLanguageContentView.layer pop_addAnimation:springAnimation forKey:@"springAnimation"];
    //**********************************************************
    
    //******旋转动画(基本动画系列)沿着 X和Y坐标轴进行缩放的动画*********
    POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnimation.toValue = @(- M_PI_4);
    rotationAnimation.duration = 0.6;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.selLanguageContentView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //**********************************************************
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(self.center.y * 3);
    positionAnimation.duration = 0.6;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished)
        {
            //*******************改变透明度动画(基本动画系列)*******************
            POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            //变暗视图图层透明度值变化
            opacityAnimation.toValue = @(0);
            opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            //最后把动画添加到指定的图层上，让动画开始生效
            [self.coverImageView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
            [opacityAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
                if (finished) {
                    
                    [self dismiss];
                    
                }
                
                
            }];
            //**************************************************************
            
        }
    }];
    [self.selLanguageContentView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
}

- (void)dismiss
{
    [self removeFromSuperview];
}


#pragma mark - 当你需要在调整subview的大小的时候需要重写
- (void)layoutSubviews
{
    /*
     layoutSubviews在以下情况下会被调用：
     
     1、init初始化不会触发layoutSubviews
     
     2、addSubview会触发layoutSubviews
     
     3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
     
     4、滚动一个UIScrollView会触发layoutSubviews
     
     5、旋转Screen会触发父UIView上的layoutSubviews事件
     
     6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
     */
    
    [super layoutSubviews];
    self.coverImageView.frame = self.bounds;
}

#pragma mark - 显示弹出菜单内容
- (void)showFromView:(UIView *)fromView
{
    //添加弹出菜单到整体的窗口上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    //******************设置内容视图的frame******************
    self.selLanguageContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) - kInterval * 10, CGRectGetHeight(self.frame) - kInterval * 28);
    //设置内容视图的初始的位置为在动画过渡视图的外部位置
    self.selLanguageContentView.center = CGPointMake(self.center.x, - self.center.y);
    //设置内容视图旋转
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(- M_PI_2/8.0);
    [self.selLanguageContentView.layer setAffineTransform:rotateTransform];
    
    //******************设置关闭视图按钮******************
    UIImage *dismissImage = [UIImage imageNamed:@"dismiss"];
    CGSize dismissButtonSize = dismissImage.size;
    self.dismissButton.frame = (CGRect){CGPointZero,dismissButtonSize};
    //self.dismissButton.center = CGPointMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y);
    [self.dismissButton setImage:dismissImage forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(coverImageViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    //******************设置表格视图的frame******************
    self.selectLanguageTableView.frame = (CGRect){self.dismissButton.center,{CGRectGetWidth(self.selLanguageContentView.bounds) - kInterval * 2,CGRectGetHeight(self.selLanguageContentView.bounds) - kInterval * 2}};
    
    //******************设置掩盖视图图片******************
    UIImage *blurredImage = [UIImage blurryGPUImage:[fromView convertViewToImage] withBlurRadiusInPixels:3];
    self.coverImageView.image = blurredImage;
    self.coverImageView.backgroundColor = kThemeColors;
    
    
    //**********位置动画(Spring弹簧系列)图层的Y坐标变化*************
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //让toView的Y坐标动画来到指定的值
    positionAnimation.toValue = @(self.center.y);
    //弹簧弹力
    positionAnimation.springBounciness = 10;
    //速度
    positionAnimation.springSpeed = 10;
    //**********************************************************
    
    //******旋转动画(基本动画系列)沿着 X和Y坐标轴进行缩放的动画*********
    POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnimation.toValue = @(0);
    rotationAnimation.duration = 0.5;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //**********************************************************
    
    //*******************改变透明度动画(基本动画系列)*******************
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    //变暗视图图层透明度值变化
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.duration = 0.5;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //**************************************************************
    
    //最后把动画添加到指定的图层上，让动画开始生效
    [self.selLanguageContentView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [self.selLanguageContentView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.coverImageView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectLanguageArr.count;
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
    
    if (indexPath.row == _selLanguageIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSDictionary *languageDict = _selectLanguageArr[indexPath.row];
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
    
    if(indexPath.row == _selLanguageIndex)
    {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_selLanguageIndex inSection:0];
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
    _selLanguageIndex = indexPath.row;
    
    if (self.selectLanguageViewBlock != nil)
    {
        NSDictionary *languageDict = _selectLanguageArr[indexPath.row];
        self.selectLanguageViewBlock(languageDict[@"language"]);
        [self coverImageViewClick];
    }
    
}

#pragma mark - SelectLanguageViewBlock方法
- (void)returnLanguageString:(SelectLanguageViewBlock)block
{
    self.selectLanguageViewBlock = block;
}



@end
