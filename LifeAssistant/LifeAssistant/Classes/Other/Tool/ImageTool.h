//
//  ImageTool.h
//  JewelryLion
//
//  Created by zhubaoshi on 14/12/6.
//  Copyright (c) 2014年 zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

// 图片缓存下载方法
/**
 * 异步下载. 图片本地缓存. 网络下载. 自动设置占位符placeholderImage.
 缓存策略options:失败再请求:SDWebImageRetryFailed，磁盘缓存:SDWebImageRefreshCached，scrollView滚动时暂停下载图片:SDWebImageLowPriority
 */
+ (void)imageToolInsteadView:(UIImageView *)imageView setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)image;

@end
