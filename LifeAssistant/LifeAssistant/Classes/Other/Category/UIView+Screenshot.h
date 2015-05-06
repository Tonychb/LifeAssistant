//
//  UIView+Screenshot.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/28.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  屏幕截图
 */
@interface UIView (Screenshot)

/**
 *  视图转换成图片
 *
 *  @return 返回转换成功的图片
 */
- (UIImage *)convertViewToImage;

@end
