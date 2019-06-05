//
//  NSString+Category.h
//  LiuMuKaMeng
//
//  Created by kira on 2018/3/12.
//  Copyright © 2018年 六沐. All rights reserved.
//
/*
 取舍类型
 //    value        1.2  1.21  1.25  1.35  1.27
 // NSRoundPlain    1.2  1.2   1.3   1.4   1.3    取整
 // NSRoundDown     1.2  1.2   1.2   1.3   1.2    只舍不入
 // NSRoundUp       1.2  1.3   1.3   1.4   1.3    只入不舍
 // NSRoundBankers  1.2  1.2   1.2   1.4   1.3    四舍五入
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Operation)

/**
 加
 */
- (NSString *(^)(NSString *num))add;

/**
 减
 */
- (NSString *(^)(NSString *num))minus;

/**
 乘
 */
- (NSString *(^)(NSString *num))multip;

/**
 除
 */
- (NSString *(^)(NSString *num))divide;

/**
 保留几位小数点
 */
- (NSString *(^)(NSInteger num,NSRoundingMode type))numType;

/**
 计算文字Size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 判断传入的数据类型是否为字符串，且长度大于0
 */
- (BOOL)isPureString;

/**
 将传入的数字字符串，截取小数点后两位，不足补0
 */
+ (NSString *)getNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount RoundingMode:(NSRoundingMode)type;

/**
 隐藏姓，显示名字
 */
- (NSString *)hideFamilyNameShowNameWithStr:(NSString *)nameString;

/**
 价格添加千位分隔符
 */
- (NSString *)addMoneyFormatter;

/**
 字符串每隔4位空格
 */
-(NSString *)stringFourWithMargin:(NSString *)str;


/**
 判断是否是字符串类型
 */
+ (BOOL)isPureString:(NSString *)string;
//字符串处理
- (NSString *)isPureNULL;
@end


@interface NSDictionary(LMObjectForKey)


/**
 是否是字符串
 */
-(NSString *)LMStringForKey:(id)key;

/**
 是否是数组
 */
-(NSArray *)LMArrayForKey:(id)key;

/**
 是否是字典
 */
-(NSDictionary *)LMDictionaryForKey:(id)key;

/**
 字典转json字符串
 */
- (NSString *)convertToJsonData;

@end

