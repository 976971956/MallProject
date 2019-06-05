//
//  UIView+BordSeting.m
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import "UIView+BordSeting.h"

@implementation UIView (BordSeting)
- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

- (BOOL)avatarCorner{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue] > 0;
}

- (void)setAvatarCorner:(BOOL)corner{
    if (corner){
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
        self.layer.masksToBounds = corner;
    }
}

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = (borderWidth > 0);
}


- (UIColor *)borderColor{
    return objc_getAssociatedObject(self, @selector(borderColor));
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
@end
