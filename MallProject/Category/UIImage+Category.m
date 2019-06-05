//
//  UIImage+Category.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+ (UIImage *)scaleImage:(UIImage *)image ScaleSize:(CGSize)scaleSize {
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
