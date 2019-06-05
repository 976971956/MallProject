//
//  NSString+Category.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Category)
- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
    [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

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

+ (NSString *)emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
}
@end
