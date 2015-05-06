//
//  UIImage+CHB.h
//  WeiBo
//
//  Created by Tonychb on 14-9-18.
//  Copyright (c) 2014年 Tonychb. All rights reserved.
//

//**********扩展已有类,新的方法实现iphone5自动加载568h@2x尺寸图片*********************

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface UIImage (CHB)

+ (UIImage *)fullScreenImage:(NSString *)string;

// 自动拉伸图片
+ (UIImage *)resizeImage:(NSString *)imageName;

/**
 *  保持原来的长宽比，生成一个缩略图
 *
 *  @param image  传进来的图片
 *  @param toSize 指定大小
 *
 *  @return 保持原来的长宽比，生成一个缩略图
 *
 *  @exception
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)toSize;


/**
 *  自动缩放到指定大小
 *
 *  @param image 传进来的图片
 *  @param asize 指定大小
 *
 *  @return 自动缩放到指定大小的缩略图
 *
 *  @exception
 */
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

///图像压缩,等比缩放
+ (UIImage *)compressImageWith:(UIImage *)image;

// 从颜色 转成 图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  使用第三方库GPUImage实现模糊图片效果
 *
 *  @param image 编辑图片
 *  @param blur  模糊度
 *
 *  @return 返回编辑后的图片
 *
 *  @exception exception description
 */
+ (UIImage *)blurryGPUImage:(UIImage *)image withBlurRadiusInPixels:(CGFloat)blurRadiusInPixels;

@end
