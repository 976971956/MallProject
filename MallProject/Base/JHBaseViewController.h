//
//  JHBaseViewController.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^refreshDataWithObj)(id obj);

@interface JHBaseViewController : UIViewController

@property(nonatomic,strong)UIImage *shadowImage;
/**
 从第几条数据开始请求
*/
@property (nonatomic, assign) NSInteger start;


/**
 一次请求多少条
 */
@property (nonatomic, assign) NSInteger limit;


/**
 从第几页开始请求 （根据后台的情况来定是否用 page）
 */
@property (nonatomic, assign) NSInteger page;


/**
 判断是上拉加载更多还是下拉刷新
 */
@property (nonatomic, assign, getter=isDown) BOOL down;


/**
 判断是否已经成功加载过数据
 */
@property (nonatomic, assign, getter=isReload) BOOL reload;


/**
 是否是当前页
 */
@property (nonatomic, assign, getter=isCurrentPage) BOOL currentPage;

/**
 标识
 */
@property (nonatomic, strong) NSString *identifier;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;


/**
 请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *parameter;


/**
 导航栏右侧标题
 */
@property (nonatomic, strong) NSString *rightItemTitle;


@property (nonatomic, copy) refreshDataWithObj refreshObj;//刷新数据

/**
 请求数据
 */
- (void)requestData;


/**
 创建 导航栏
 */
- (void)createNavagation;


/**
 导航条返回按钮方法，子类根据实际需要可重写此方法（例如返回刷新上个界面等）
 */
- (void)back;


/**
 导航条是否透明
 
 @param translucent 是否透明
 */
- (void)setNavigationBarTranslucent:(BOOL)translucent;


/**
 改变导航条的透明度 （使用场景：根据TableView的contentOffsetl来改变导航条的透明度）
 
 @param alpha 透明度
 */
- (void)setNavigationBarWithAlpha:(CGFloat)alpha;


- (void)rightItemClick;

+ (instancetype)loadControllerForNib;

-(UIImage *)imageWithBgColor:(UIColor *)color;
@end
