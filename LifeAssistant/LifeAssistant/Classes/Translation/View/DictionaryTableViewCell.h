//
//  DictionaryTableViewCell.h
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/21.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictCellFrame.h"

@interface DictionaryTableViewCell : UITableViewCell

@property (nonatomic,strong) DictCellFrame *dictCellFrame;

+ (NSString *)ID;

@end
