//
//  JHNavigationController.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>

@end

@implementation JHNavigationController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.navigationBar.translucent = NO;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                     JHColorA(51, 51, 51, 1), NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    navBar.translucent = NO;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navBackground"] forBarMetrics:UIBarMetricsDefault];
    navBar.tintColor = JHColorA(51, 51, 51, 1);
    navBar.translucent = YES;
    
    [navBar setBackIndicatorImage:[UIImage imageNamed:@"common_nav_btn_back"]];
    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"common_nav_btn_back"]];
    
    //    //去掉返回两字
    //    UIBarButtonItem  *baritem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    //    UIOffset offset;    offset.horizontal = -500;
    //    [baritem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

@end
