//
//  UIView+BordSeting.h
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BordSeting)
@property (nonatomic) IBInspectable CGFloat cornerRadius;

/** 头像圆角 */
@property (nonatomic) IBInspectable BOOL avatarCorner;

/** 边框 */
@property (nonatomic) IBInspectable CGFloat borderWidth;

/** 边框颜色*/
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@end
