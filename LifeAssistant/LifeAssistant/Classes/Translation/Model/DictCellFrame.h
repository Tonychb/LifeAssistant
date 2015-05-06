//
//  DictCellFrame.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/23.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DictData;

@interface DictCellFrame : NSObject

@property (nonatomic,strong) DictData *dictData;

/**
 *  请求词语的尺寸
 */
@property (nonatomic,readonly) CGRect wordNameFrame;

/**
 *  音标尺寸
 */
@property (nonatomic,readonly) CGRect phoneticFrame;

/**
 *  多个词性组成的字符串尺寸
 */
@property (nonatomic,readonly) CGRect partsFrame;

/**
 *  cell内容高度
 */
@property (nonatomic,readonly) CGFloat dictCellHeight;

/**
 *  音标字符串
 */
@property (nonatomic,readonly) NSString *phoneticStr;

/**
 *  多个词性组成的字符串
 */
@property (nonatomic,readonly) NSMutableString *partsStr;


@end
