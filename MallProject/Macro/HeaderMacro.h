//
//  HeaderMacro.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#ifndef HeaderMacro_h
#define HeaderMacro_h

//打印日志
#ifdef DEBUG //开发
#define NSLog(fmt, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d] 打印数据:" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else //发布
#define NSLog(...)
#endif

/** self的弱引用 */
#define KWeakSelf(type)  __weak typeof(type) weak##type = type;

// rgb颜色转换（16进制->10进制）
#define JHColor16RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//rgb取色
#define JHColorA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//随机色
#define RandomColor LMColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//屏幕宽度
#define ScreenW  [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define ScreenH  [UIScreen mainScreen].bounds.size.height

//导航栏的高度
#define JHNavHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)
//状态栏高度
#define JHStatuesHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 44 : 20)
//底部安全区域的高度
#define JHBottomHomeBarHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 34 : 0)

//获取手机系统版本
#define IOS_SystemVersion [[UIDevice currentDevice] systemVersion]
//获取APP的Version
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取APP的build
#define APP_Build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//获取当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])
#endif /* HeaderMacro_h */
