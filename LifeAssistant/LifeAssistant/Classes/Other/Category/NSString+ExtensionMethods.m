//
//  NSString+ExtensionMethods.m
//  JewelryLion
//
//  Created by zhubaoshi on 14/11/7.
//  Copyright (c) 2014年 JewelryLion. All rights reserved.
//

#import "NSString+ExtensionMethods.h"

@implementation NSString (ExtensionMethods)

#pragma mark - 自定义字符串拼接方法
- (NSString *)StringConcatenation:(NSString *)string
{
    //获取文件扩展名
    NSString *extension = [self pathExtension];
    
    //去除文件扩展名
    NSString *str = [self stringByDeletingPathExtension];
    
    //追加iPhone5特殊文件名字符串
    str = [str stringByAppendingString:string];
    
    //添加文件扩展名,得到完整的文件名
    str = [str stringByAppendingPathExtension:extension];
    
    return str;
}

#pragma mark -  中文转拼音
+ (NSString *)chineseChangePinyin:(NSString *)sourceString
{
    /*
     Boolean CFStringTransform(CFMutableStringRef string, CFRange *range, CFStringRef transform, Boolean reverse);
     
     其中string参数是要转换的string，比如要转换的中文，同时它是NSMutableString的，因此也直接作为最终转换后的字符串。range是要转换的范围，同时输出转换后改变的范围，如果为NULL，视为全部转换。transform可以指定要进行什么样的转换，这里可以指定多种语言的拼写转换。reverse指定该转换是否必须是可逆向转换的。如果转换成功就返回true，否则返回false。
     
     kCFStringTransformMandarinLatin汉字转到音标字母,再用kCFStringTransformStripDiacritics音标字母转为普通字母
     
     */
    if ([sourceString isEqualToString:@""])
    {
        return sourceString;
    }
    
    NSMutableString *source = [sourceString mutableCopy];
    
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"长"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 5)withString:@"chang"];
        
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"沈"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
        
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"厦"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
        
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"地"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 2)withString:@"di"];
        
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"重"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
        
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"曾"] ==NSOrderedSame)
        
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 4) withString:@"zeng"];
        
    }
    
    //字符串替换出现的字符串
    NSString *sourceStr =  [source stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    return sourceStr;

}


///// 手机号码的有效性判断
//检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//验证邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
