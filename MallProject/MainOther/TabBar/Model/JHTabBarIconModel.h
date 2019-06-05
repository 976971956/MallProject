//
//  JHTabBarIconModel.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTabBarIconModel : NSObject
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *iconPic1View;
@property (nonatomic, copy) NSString *iconPic2View;
@property (nonatomic, copy) NSString *interfacePosition;
@property (nonatomic, copy) NSString *interfaceType;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *selectedIconImage;
@end
