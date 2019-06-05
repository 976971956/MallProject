//
//  NSString+Category.m
//  LiuMuKaMeng
//
//  Created by kira on 2018/3/12.
//  Copyright © 2018年 六沐. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Operation)
#pragma mark =========加=========
- (NSString *(^)(NSString *num))add {
    return ^(NSString *num){
        if (![num isPureString]) {
            num = @"0";
        }
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num];
        NSDecimalNumber *summation = [number1 decimalNumberByAdding:number2];
        NSString *numStr = summation.stringValue;
        return numStr;
    };
}
#pragma mark =========减=========
- (NSString *(^)(NSString *num))minus {
    return ^(NSString *num){
        if (![num isPureString]) {
            num = @"0";
        }
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num];
        NSDecimalNumber *summation = [number1 decimalNumberBySubtracting:number2];
        NSString *numStr = summation.stringValue;
        return numStr;
    };
}
#pragma mark =========乘=========
- (NSString *(^)(NSString *num))multip {
    return ^(NSString *num){
        if (![num isPureString]) {
            num = @"0";
        }
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num];
        NSDecimalNumber *summation = [number1 decimalNumberByMultiplyingBy:number2];
        NSString *numStr = summation.stringValue;
        return numStr;
    };
}
#pragma mark =========除=========
- (NSString *(^)(NSString *num))divide {
    return ^(NSString *num){
        if (![num isPureString]) {
            num = @"0";
        }
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num];
        NSDecimalNumber *summation = [number1 decimalNumberByDividingBy:number2];
        NSString *numStr = summation.stringValue;
        return numStr;
    };
}
#pragma mark =========保留小数位和取舍类型=========
- (NSString *(^)(NSInteger num, NSRoundingMode type))numType{
    return ^(NSInteger num , NSRoundingMode type){
        return [NSString getNumberWithDigit:self DecimalCount:num RoundingMode:type];
    };
}

#pragma mark - 计算文字Size
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 判断传入的数据类型是否为字符串，且长度大于0
- (BOOL)isPureString {
    if ([self isKindOfClass:[NSString class]]) {
        if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

+ (NSString *)getNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount RoundingMode:(NSRoundingMode)type {
    if (![digit isPureString]) {
        digit = @"0";
    }
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:type
                                                                                             scale:decimalCount
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *totalAmount = [NSDecimalNumber decimalNumberWithString:digit];
    NSDecimalNumber *resultDN = [totalAmount decimalNumberByRoundingAccordingToBehavior:handler];
    
    NSMutableString *result = [NSMutableString string];
    
    NSString *numberStr = resultDN.stringValue;
    
    if ([numberStr containsString:@"."]) {
        //小数部分
        NSString *floatStr = [[numberStr componentsSeparatedByString:@"."] lastObject];
        
        if (floatStr.length == decimalCount) {
            [result appendString:numberStr];
            
            return result;
        } else { //小数点后面位数不足需补0
            [result appendString:numberStr];
            
            for (int i = 0; i < (decimalCount - floatStr.length); i ++) {
                [result appendString:@"0"];
            }
            return result;
        }
    } else {
        if (decimalCount == 0) {
            [result appendString:[NSString stringWithFormat:@"%@",numberStr]];
        } else {
            [result appendString:[NSString stringWithFormat:@"%@.",numberStr]];
            
            for (int i = 0; i < decimalCount; i ++) {
                [result appendString:@"0"];
            }
        }
        return result;
    }
}

#pragma mark - 隐藏姓显示名字
-(NSString *)hideFamilyNameShowNameWithStr:(NSString *)nameString
{
    NSString *nameStr;
    if (nameString.length) {
        int longtag = (int)nameString.length-1;
        nameStr = longtag>0 ? [nameString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"] : nameString;
    }
    return nameStr;
}

#pragma mark - 字符串每隔4位空格
-(NSString *)stringFourWithMargin:(NSString *)str
{
    NSMutableArray *numberArr = [NSMutableArray array];
    int length =str.length % 4 == 0 ? (int)(str.length / 4) : (int)(str.length / 4 + 1);
    for (int i = 0; i < length; i++) {
        int begin = i * 4;
        int end = (i * 4 + 4) > (int)str.length ? (int)(str.length) : (i * 4 + 4);
        NSString *subString = [str substringWithRange:NSMakeRange(begin, end - begin)];
        [numberArr addObject:subString];
    }
    NSString *cardnbr = @"";
    for (int i = 0; i < length; i++) {
        cardnbr = [cardnbr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@ ",numberArr[i]]];
    }
    return  cardnbr;
}

#pragma mark - 价格添加千位分隔符
- (NSString *)addMoneyFormatter {
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    if ([self isPureString]) {
        if ([self containsString:@"."]) {
            moneyFormatter.positiveFormat = @"###,##0.00";
        } else {
            moneyFormatter.positiveFormat = @"###,###";
        }
        
        NSString *tempString = [moneyFormatter stringFromNumber:[moneyFormatter numberFromString:self]];
        
        return tempString;
    } else {
        return @"0";
    }
}
#pragma mark - 判断是否为字符串类型
+ (BOOL)isPureString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}


- (NSString *)isPureNULL{
    if (![NSString isPureString:self]) {
        return @"";
    }
    return self;
}

@end


@implementation NSDictionary(LMObjectForKey)

-(NSString *)LMStringForKey:(id)key
{
    id object=[self objectForKey:key];
    
    if ([object isKindOfClass:[NSNull class]]||object == nil)
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",object];
}

-(NSArray *)LMArrayForKey:(id)key
{
    id object=[self objectForKey:key];
    
    if (![object isKindOfClass:[NSArray class]])
    {
        return [NSArray array];
    }
    return object;
}

-(NSDictionary *)LMDictionaryForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (![object isKindOfClass:[NSDictionary class]])
    {
        return [NSDictionary dictionary];
    }
    return object;
}

//字典转jason字符串
- (NSString *)convertToJsonData {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        jsonString = @"";
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}


@end
