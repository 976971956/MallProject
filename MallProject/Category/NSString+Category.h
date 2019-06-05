//
//  NSString+Category.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
- (NSString *)md5String;
+ (BOOL)isPureString:(NSString *)string;

+ (NSString *)emptyStr:(NSString *)str;
@end
