//
//  UINavigationBar+NavBackGroudColor.h
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NavBackGroudColor)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
