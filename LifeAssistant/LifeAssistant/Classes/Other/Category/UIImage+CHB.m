//
//  UIImage+CHB.m
//  WeiBo
//
//  Created by Tonychb on 14-9-18.
//  Copyright (c) 2014年 Tonychb. All rights reserved.
//

//****************分类实现iphone5自动加载568h@2x尺寸图片*********************
#import "NSString+ExtensionMethods.h"

@implementation UIImage (CHB)

//新创建一个方法来自适应iphone不同尺寸屏幕的图片展示
+ (UIImage *)fullScreenImage:(NSString *)string
{
    //根据屏幕高度判断iphone5
    if (isIPhone5)
    {
        //扩展NSString类，自定义字符串拼接方法
        string = [string StringConcatenation:@"-568h@2x"];
    }
    return [self imageNamed:string];
}

// 自动拉伸图片
+ (UIImage *)resizeImage:(NSString *)imageName
{
    /*
     stretchableImageWithLeftCapWidth:topCapHeight:功能是创建一个内容可拉伸，而边角不拉伸的图片，
     需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
     */
    //以长度的一半，高度的一半为中心进行拉伸。
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
}


#pragma mark - 保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)toSize
{
    UIImage *newImage;
    if (image == nil)
    {
        newImage = nil;
    }
    else
    {
        //原来获取的图片的大小
        CGSize oldSize = image.size;
        CGRect rect;
        if (toSize.width / toSize.height > oldSize.width / oldSize.height)
        {
            rect.size.width = toSize.height * oldSize.width / oldSize.height;
            rect.size.height = toSize.height;
            rect.origin.x = (toSize.width - rect.size.width) / 2;
            rect.origin.y = 0;
        }
        else
        {
            rect.size.width = toSize.width;
            rect.size.height = toSize.width*oldSize.height / oldSize.width;
            rect.origin.x = 0;
            rect.origin.y = (toSize.height - rect.size.height) / 2;
        }
        //UIGraphicsBeginImageContext,创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)。
        UIGraphicsBeginImageContext(toSize);
        //CGContextRef画各种图形,获得处理的上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        //填充颜色
        CGContextSetFillColorWithColor(context, [[UIColor clearColor]CGColor]);
        UIRectFill(CGRectMake(0, 0, toSize.width, toSize.height));
        //绘制改变大小的图片,在当前图形上下文的指定矩形内绘制文本。
        [image drawInRect:rect];
        // 从当前context中创建一个改变大小后的图片
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        //使当前的context出堆栈
        UIGraphicsEndImageContext();
    }
    
    return newImage;
    
}


#pragma mark - 自动缩放到指定大小

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        UIGraphicsBeginImageContext(asize);
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;

}

#pragma mark - 图像压缩,等比缩放
+ (UIImage *)compressImageWith:(UIImage *)image
{
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat width = 640;
    CGFloat height = image.size.height/(image.size.width/width);
    
    CGFloat widthScale = imageWidth /width;
    CGFloat heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


#pragma mark - 工具方法
// 从颜色 转成 图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

#pragma mark - 使用第三方库GPUImage实现模糊效果
//BlurLevel模糊度
+ (UIImage *)blurryGPUImage:(UIImage *)image withBlurRadiusInPixels:(CGFloat)blurRadiusInPixels
{
    
    GPUImageiOSBlurFilter *iOSBlurFilter = [[GPUImageiOSBlurFilter alloc]init];
    
    //模糊半径以像素为单位
    iOSBlurFilter.blurRadiusInPixels = blurRadiusInPixels;
    
    UIImage *result = [iOSBlurFilter imageByFilteringImage:image];
    
    return result;
    
}



@end
