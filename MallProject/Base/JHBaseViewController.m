//
//  JHBaseViewController.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseViewController ()
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIButton *leftBtn;
@end

@implementation JHBaseViewController

+ (instancetype)loadControllerForNib
{
    return [[JHBaseViewController alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}


- (NSMutableDictionary *)parameter
{
    if (_parameter == nil) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentPage = YES;
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.currentPage = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavagation];
}

- (UIBarButtonItem *)rightItem
{
    if (_rightItem == nil) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 44, 44);
        [rightBtn setImage:[UIImage imageNamed:@""] forState:0];
        [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
        self.rightBtn = rightBtn;
        _rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    }
    return _rightItem;
}

-(UIBarButtonItem *)leftItem {
    if (_leftItem == nil) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 60, 44);
        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:0];
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn = leftBtn;
        _leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    }
    return _leftItem;
}
#pragma mark 导航栏右侧点击事件
- (void)rightItemClick
{
    
}

//设置右边标题
- (void)setRightItemTitle:(NSString *)rightItemTitle
{
    _rightItemTitle = rightItemTitle;
    
    self.rightItem.title = _rightItemTitle;
    
    if (self.navigationController) {
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }
}


#pragma mark -创建导航栏
- (void)createNavagation{
    
    if (self.navigationController.viewControllers.count > 1) {
        if (self.navigationController && !self.navigationController.isNavigationBarHidden ) {
            self.navigationItem.backBarButtonItem = self.leftItem;
        }
    }
    
    if (self.navigationController) {
        
        self.shadowImage = self.navigationController.navigationBar.shadowImage;
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
    }
    
}



- (void)requestData
{
    /**
     *  该方法由子类自行实现，父类不做实现
     */
}




- (void)back{
    
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)setNavigationBarTranslucent:(BOOL)translucent{
    
    if (self.navigationController == nil) return;
    
    if (translucent) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        self.navigationController.navigationBar.translucent = YES ;
        
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:JHColorA(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:JHColorA(0, 0, 0, 0)]];
        
    } else {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setShadowImage:self.shadowImage];
    }
    
    
}

- (void)setNavigationBarWithAlpha:(CGFloat)alpha{
    if (alpha >= 1) {
        alpha = 0.98;
    }
    if (alpha < 0.1) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:JHColorA(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:JHColorA(0, 0, 0, 0)]];
        
    } else if (alpha > 0.1) {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:JHColorA(255, 255, 255, alpha)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:self.shadowImage];
        
    }
    
}





-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)dealloc
{
    NSLog(@"%@  -> 销毁 ====", self.class);
}


@end
