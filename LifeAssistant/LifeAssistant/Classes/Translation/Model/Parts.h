//
//  Parts.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/20.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  词性数组
 */
@interface Parts : NSObject

/**
 *  该词性情况下的释义数组
 */
@property (nonatomic,strong)NSArray *means;

/**
 *  每个翻译的词性
 */
@property (nonatomic,copy) NSString *part;

@end
