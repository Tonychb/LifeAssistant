//
//  RegisterTextField.m
//  JewelryLion-EC
//
//  Created by zhubaoshi on 15/3/31.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "RegisterTextField.h"

@implementation RegisterTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.layer.borderWidth = 1.0;
//        self.layer.borderColor = [[UIColor colorFromHexRGB:@"bdbdbd" withAlpha:1] CGColor];
//        self.layer.cornerRadius = 5.0;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        //设置边框样式，只有设置了才会显示边框样式
        /*
         UITextBorderStyleNone,无框
         UITextBorderStyleLine,线框
         UITextBorderStyleBezel,bezel风格线框
         UITextBorderStyleRoundedRect,圆角边框
         */
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        //设置字体颜色
        self.textColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:13];
        //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        //再次编辑就清空
        //self.clearsOnBeginEditing = YES;
        //内容对齐方式
        self.textAlignment = NSTextAlignmentLeft;
        //内容的垂直对齐方式  UITextField继承自UIControl,此类中有一个属性contentVerticalAlignment
//        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
    }
    return self;
}

//#pragma mark - 控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
//}
//
//#pragma mark - 控制placeHolder的位置，左右缩20
//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    
//    //return CGRectInset(bounds, 20, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y + 20, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
//}
//#pragma mark - 控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
//    
//}
//#pragma mark - 控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width - 10, bounds.size.height);
//    return inset;
//}

#pragma mark - 控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
//    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width - 225, bounds.size.height);
//    return inset;
//    //return CGRectInset(bounds,50,0);
    
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    leftViewRect.origin.x += kInterval;
    return leftViewRect;
}

//#pragma mark - 控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    CGRect placeholderRect = CGRectInset(rect, 0, kInterval);
//    [[self placeholder] drawInRect:placeholderRect withAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexRGB:@"a0a0a0" withAlpha:1],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//}

@end
