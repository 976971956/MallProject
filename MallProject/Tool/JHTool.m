//
//  JHTool.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHTool.h"
#import "JHTabBarViewController.h"
@interface JHTool()

@end
@implementation JHTool

static NSString *Version = @"Version";

+ (UIViewController *)chooseWindowRootVC
{
    // 判断下当前有没有最新的版本
    // 获取上一次保存的最新版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:Version];
    UIViewController *rootVc;
    
    if ([IOS_SystemVersion isEqualToString:lastVersion]) { // 相等
        // 没新版本，进入主框架界面
        rootVc = [[JHTabBarViewController alloc]init];
    }else{ // 表示有最新的版本号，进入新特性界面
        // 如果有，进入引导页
        [[NSUserDefaults standardUserDefaults] setObject:IOS_SystemVersion forKey:Version];
    }
    
    return rootVc;
}

@end
