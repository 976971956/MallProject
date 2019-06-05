//
//  JHTabBarViewController.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHTabBarIconModel.h"
#import "JHNavigationController.h"
#import "JHHomeViewController.h"
#import "JHCategoryViewController.h"
#import "JHBuyCartViewController.h"
#import "JHMeViewController.h"
#import "UIImage+Category.h"
@interface JHTabBarViewController ()<UITabBarControllerDelegate>
//自定义tabbar的数据模型
@property(nonatomic,strong)NSMutableArray *items;

@property (nonatomic, strong) NSMutableArray *tabBarBtnArray;

@property (nonatomic, assign) BOOL isLoadTabBarBtn;

@property (nonatomic, strong) NSArray *orignalImageArray;

@property (nonatomic, strong) NSArray *selectImageArray;

@property (nonatomic, strong) NSMutableArray *animationImageArray;

@property (nonatomic, assign) NSInteger previousIndex;

@property (nonatomic, strong) NSArray *iconModelArray;

@property (nonatomic)dispatch_group_t group;

@property (nonatomic, assign) BOOL isErrorIcon;// 请求的tabbarIcon中只要有一张图片尺寸有问题，则全部图片都不使用


@end

@implementation JHTabBarViewController

//自定义tabbar的懒加载
- (NSMutableArray *)items
{
    if (_items == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _items = array;
    }
    return _items;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBar.translucent = NO;
        
        [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBackGround"]];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        //item选中状态颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        //item默认状态颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor grayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!self.tabBarBtnArray) {
        self.tabBarBtnArray = [NSMutableArray array];
    }
    if (!self.isLoadTabBarBtn) {
        for (UIControl *tabBarButton in self.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [self.tabBarBtnArray addObject:tabBarButton];
                [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    self.isLoadTabBarBtn = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.tabBar.translucent = NO;
    
//网络获取icon图标
    NSString *url = @"https://shop.lmcity.cn/api/get/cm/libIcon/qryByTypeAndPosition";
    NSDictionary *parameters = @{@"interfaceType":@"09", @"interfacePosition":@"3", @"tokenid":@""};
    
    [JHNetWorking shareInstance].post(url, parameters).showhud(YES).success(^(NSDictionary *dict, BOOL successful, JHError *error) {
        self.isErrorIcon = NO;

        if (successful) {
            NSArray *data= [dict objectForKey:@"data"];
            self.iconModelArray = [JHTabBarIconModel mj_objectArrayWithKeyValuesArray:data];
            [self updateIconImage];
        } else {
            
        }
    }).failure(^(NSError *error) {
        
    });
    self.orignalImageArray = @[@"icon_mall_1", @"icon_assortment_1", @"icon_shopping_1", @"icon_invite_1", @"icon_personal_1"];
    self.selectImageArray = @[@"icon_mall_5", @"icon_assortment_5", @"icon_shopping_5", @"icon_invite_5", @"icon_personal_5"];
    
    UIView *marginView = [[UIView alloc] init];
    marginView.backgroundColor = JHColorA(230, 230, 230, 1);
    marginView.frame =CGRectMake(0, 0, ScreenW, 1);
    [self.tabBar addSubview:marginView];
    
    [self addChildViewController:[JHNavigationController class] viewControl:[JHHomeViewController class] navigationItem:@"首页" tabBarItem:@"首页" image:self.orignalImageArray[0] selectImage:self.selectImageArray[0]];
    
    [self addChildViewController:[JHNavigationController class] viewControl:[JHCategoryViewController class] navigationItem:@"分类" tabBarItem:@"分类" image:self.orignalImageArray[1] selectImage:self.selectImageArray[1]] ;
    
    [self addChildViewController:[JHNavigationController class] viewControl:[JHBuyCartViewController class] navigationItem:@"购物车" tabBarItem:@"购物车" image:self.orignalImageArray[2] selectImage:self.selectImageArray[2]];
    
    [self addChildViewController:[JHNavigationController class] viewControl:[JHMeViewController class] navigationItem:@"我的" tabBarItem:@"我的" image:self.orignalImageArray[4] selectImage:self.selectImageArray[4]];
}

- (void)addChildViewController:(Class)class viewControl:(Class)childClass navigationItem:(NSString *)navTitle tabBarItem:(NSString *)tabTitle image:(NSString *)imageTitle selectImage:(NSString*)selectImageTitle{
    UINavigationController *nav = [[class alloc] init];
    
    nav.tabBarItem.title = tabTitle;
    nav.tabBarItem.image = [[UIImage imageNamed:imageTitle] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageTitle] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *child = [[childClass alloc] init];
    child.title = navTitle;
    [nav pushViewController:child animated:YES];
    [self addChildViewController:nav];
}

#pragma mark - 点击tabBarBtn填充动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if  (!self.isErrorIcon) { // 要使用网络请求的活动图标，不用动画
        return;
    }
    
//    已经点击过就无需再次执行动画了
    if (self.previousIndex == self.selectedIndex) {
        return;
    }
    self.previousIndex = self.selectedIndex;
    
//    获取数组中元素位置
    NSInteger index = [self.tabBarBtnArray indexOfObject:tabBarButton];
    
    [self changeAnimationImageWithIndex:index];
    
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
            animation.values = self.animationImageArray;
            animation.duration = self.animationImageArray.count * 0.03;
            animation.calculationMode = kCAAnimationCubic;
            animation.removedOnCompletion = YES;
            animation.fillMode = kCAFillModeForwards;
            
            //            [imageView.layer removeAllAnimations];
            [imageView.layer addAnimation:animation forKey:@"playFrameAnimation"];
        }
    }
}

- (void)changeAnimationImageWithIndex:(NSInteger)index {
    if (!self.animationImageArray) {
        self.animationImageArray = [NSMutableArray array];
    }
    [self.animationImageArray removeAllObjects];
    
    NSString *animationName = @"";
    if (index == 0) {
        animationName = @"icon_mall_";
    } else if (index == 1) {
        animationName = @"icon_assortment_";
    } else if (index == 2) {
        animationName = @"icon_shopping_";
    } else if (index == 3) {
        animationName = @"icon_invite_";
    } else if (index == 4) {
        animationName = @"icon_personal_";
    }
    
    for (int i = 0; i < 5; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%i",animationName,i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [self.animationImageArray addObject:(__bridge id)image.CGImage];
    }
}

-(BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //    if ([viewController.tabBarItem.title isEqualToString:@"邀请有礼"]) {
    //        if (![self isUserLogin]) {
    //            LMLoginViewController *loginVC = [[LMLoginViewController alloc]init]; //登陆界面
    //            loginVC.selectedIndex  = 3;    //将所选的TabbarItem 传入登陆界面
    //            UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];   //使登陆界面的Navigationbar可以显示出来
    //            [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginNav animated:YES completion:nil]; //跳转登陆界面
    //
    //            // 这方法暂时不用
    //            //在登陆界面判断登陆成功之后发送通知,将所选的TabbarItem传回,使用通知传值
    ////            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logSelect:) name:@"LoginPageDidLoginNotification" object:nil];     //接收
    //
    //            return NO;
    //        }else{
    //            return YES;
    //        }
    //    }else{
    //        return YES;
    //    }
    return YES;
}


- (void)logSelect:(NSNotification *)text{
    // 以前的方法，暂时不用
    self.selectedIndex = [text.userInfo[@"logSelect"] integerValue];
}

- (void)updateIconImage {
    if (self.iconModelArray.count > 0) {
        self.group = dispatch_group_create();
        for (JHTabBarIconModel *icon in self.iconModelArray) {
            [self downloadIconImageWithIcon:icon];
        }
        
        // group notify
        dispatch_group_notify(self.group, dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateTabBarIcon];
            });
        });
    }
}

- (void)downloadIconImageWithIcon:(JHTabBarIconModel *)icon {
    //    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:icon.iconPic1View]];
    //    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
    dispatch_group_enter(self.group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SDWebImageManager *manager = [SDWebImageManager sharedManager] ;
        [manager loadImageWithURL:[NSURL URLWithString:icon.iconPic1View] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            icon.iconImage = image;
            dispatch_group_leave(self.group);
        }];
    });
    
    dispatch_group_enter(self.group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SDWebImageManager *manager = [SDWebImageManager sharedManager] ;
        [manager loadImageWithURL:[NSURL URLWithString:icon.iconPic2View] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            icon.selectedIconImage = image;
            dispatch_group_leave(self.group);
        }];
    });
}

- (void)updateTabBarIcon {
    for (JHTabBarIconModel *icon in self.iconModelArray) {
        if (!icon.iconImage) {
            self.isErrorIcon = YES;
        }
        if (!icon.selectedIconImage) {
            self.isErrorIcon = YES;
        }
    }
    if (self.iconModelArray.count == 5 && !self.isErrorIcon) {
        for (int i = 0; i < 5; i ++) {
            UINavigationController *nav = (UINavigationController *)self.childViewControllers[i];
            JHTabBarIconModel *iconModel = self.iconModelArray[i];
            UIImage *tempImage = [UIImage scaleImage:iconModel.iconImage ScaleSize:CGSizeMake(25, 25)];
            UIImage *tempSelectedImage = [UIImage scaleImage:iconModel.selectedIconImage ScaleSize:CGSizeMake(25, 25)];
            nav.tabBarItem.image = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [tempSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            if ([NSString isPureString:iconModel.iconName]) {
                nav.tabBarItem.title = iconModel.iconName;
            }
        }
    }
}

@end
