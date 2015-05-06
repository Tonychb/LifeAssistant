//
//  DictionaryTableViewCell.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/21.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "DictionaryTableViewCell.h"
#import "DictData.h"

@interface DictionaryTableViewCell ()

@property (nonatomic,strong) UILabel *wordName;//请求词语标签
@property (nonatomic,strong) UILabel *phonetic;//音标标签
@property (nonatomic,strong) UILabel *partsLabel;//词性组标签

@end


@implementation DictionaryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //请求词语标签
        self.wordName = [[UILabel alloc]init];
        self.wordName.numberOfLines = 0;
        self.wordName.textColor = kTabBarTitleNormalColor;
        self.wordName.font = kButtonTitleFont;
        [self.contentView addSubview:self.wordName];
        
        //音标标签
        self.phonetic = [[UILabel alloc]init];
        self.phonetic.numberOfLines = 0;
        self.phonetic.font = kButtonTitleFont;
        self.phonetic.textColor = kTabBarTitleNormalColor;
        [self.contentView addSubview:self.phonetic];
        
        //词性组标签
        self.partsLabel = [[UILabel alloc]init];
        self.partsLabel.numberOfLines = 0;
        self.partsLabel.font = kButtonTitleFont;
        self.partsLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.partsLabel];

    }
    return self;
}

#pragma mark - 设置单元格（成员变量dictCellFrame的重写set方法
- (void)setDictCellFrame:(DictCellFrame *)dictCellFrame
{
    //将创建好的Frame对象赋值给成员变量
    _dictCellFrame = dictCellFrame;
    
    //设置单元格里控件布局
    [self dictCellSettingFrame];
    
    //设置单元格里控件的内容
    [self dictCellSettingContent];
}

#pragma mark - 设置单元格里控件布局
- (void)dictCellSettingFrame
{
    self.wordName.frame = _dictCellFrame.wordNameFrame;
    
    self.phonetic.frame = _dictCellFrame.phoneticFrame;
    
    self.partsLabel.frame = _dictCellFrame.partsFrame;

}

#pragma mark - 设置单元格里控件的内容
- (void)dictCellSettingContent
{
    DictData *dictData = _dictCellFrame.dictData;
    
    self.wordName.text = dictData.word_name;
    
    self.phonetic.text = _dictCellFrame.phoneticStr;
    
    self.partsLabel.text = _dictCellFrame.partsStr;
    
}



+ (NSString *)ID
{
    return @"DictionaryTableViewCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
