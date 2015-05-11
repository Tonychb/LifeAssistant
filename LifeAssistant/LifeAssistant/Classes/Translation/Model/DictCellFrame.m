//
//  DictCellFrame.m
//  PrivateTranslation
//
//  Created by zhubaoshi on 15/4/23.
//  Copyright (c) 2015年 cn.zhubaoshi. All rights reserved.
//

#import "DictCellFrame.h"
#import "DictData.h"
#import "Symbols.h"
#import "Parts.h"

@implementation DictCellFrame

- (void)setDictData:(DictData *)dictData
{
    _dictData = dictData;
    
    CGFloat labelWidth = kScreenSize.width - kInterval * 2;
    
    //请求的词语
    /**
     *  返回值：一个矩形，大小等于文本绘制完将占据的宽和高。
     *  - (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context
     *
     *  参数：Size：宽高限制，用于计算文本绘制时占据的矩形块。
     *  参数：(NSStringDrawingOptions)options：文本绘制时的附加选项。
     *      NSStringDrawingTruncatesLastVisibleLine：如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。
     *      NSStringDrawingUsesLineFragmentOrigin：那么整个文本将以每行组成的矩形为单位计算整个文本的尺寸。
     *      NSStringDrawingUsesFontLeading:计算行高时使用行间距。(注：字体大小+行间距=行距）
     *      NSStringDrawingUsesDeviceMetrics:
     *
     *  参数：attributes:将文本UIFont存入字典传到这里,意为该字符串在某种字体状态下所占据的尺寸
     *  参数：context：上下文。包括一些信息，例如如何调整字间距以及缩放。最终，该对象包含的信息将用于文本绘制。该参数可为 nil 。
     *
     */
    CGSize wordNameSize = [dictData.word_name boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kButtonTitleFont} context:nil].size;
    _wordNameFrame = (CGRect){{kInterval,kInterval},wordNameSize};
    
    //音标
    Symbols *symbols = dictData.symbols[0];
    if ([symbols.ph_zh isEqual:[NSNull null]] || symbols.ph_zh == nil || [symbols.ph_zh isEqualToString:@""])
    {
        if ([symbols.ph_am isEqual:[NSNull null]] || [symbols.ph_en isEqual:[NSNull null]] || symbols.ph_am == nil || symbols.ph_en == nil || [symbols.ph_am isEqualToString:@""] || [symbols.ph_en isEqualToString:@""])
        {
            return;
        }
        else
        {
            _phoneticStr = [NSString stringWithFormat:@"英[%@],美[%@]",symbols.ph_en,symbols.ph_am];
        }
        
    }
    else
    {
        _phoneticStr = [NSString stringWithFormat:@"拼音[%@]",symbols.ph_zh];
    }
    
    CGSize phoneticSize = [_phoneticStr boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kButtonTitleFont} context:nil].size;
    _phoneticFrame = (CGRect){{kInterval,CGRectGetMaxY(_wordNameFrame) + kInterval},phoneticSize};
    
    
    //多个词性
    NSString *partStr = nil;
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    _partsStr = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < symbols.parts.count; i ++ )
    {
        Parts *parts = symbols.parts[i];
        [mutableString deleteCharactersInRange:(NSMakeRange(0, mutableString.length))];
        for (NSInteger j = 0; j < parts.means.count; j ++)
        {
            if (j == parts.means.count - 1)
            {
                [mutableString appendString:parts.means[j]];
            }
            else
            {
                [mutableString appendFormat:@"%@;",parts.means[j]];
            }
            
        }
        if ([parts.part isEqualToString:@""] ||  [parts.part isEqual:[NSNull null]] || parts.part == nil )
        {
            partStr = [NSString stringWithFormat:@"%@",mutableString];
        }
        else
        {
            partStr = [NSString stringWithFormat:@"<%@> %@",parts.part,mutableString];
        }
        
        if (i == symbols.parts.count - 1)
        {
            [_partsStr appendString:partStr];
        }
        else
        {
            [_partsStr appendFormat:@"%@\n",partStr];
        }
        
        
    }
    
    CGSize partLabelSize = [_partsStr boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kButtonTitleFont} context:nil].size;
    
    _partsFrame = (CGRect){{kInterval,CGRectGetMaxY(_phoneticFrame) + kInterval},partLabelSize};
    
    _dictCellHeight = CGRectGetMaxY(_partsFrame) + kInterval;
    
    
}

@end
