//
//  JHDataModel.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JHDataModelType) {
    JHDataModelType1,
    JHDataModelType2,
    JHDataModelType3,
    JHDataModelType4,
    JHDataModelType5,
};
@interface JHDataModel : NSObject
/**
    字典模型（使用场景：1.比较简单的数据
 */
@property (nonatomic, strong) NSDictionary *dicModel;

/**
 cell复用标识
 */
@property (nonatomic, strong) NSString *cellID;

/**
 行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 item 的Size
 */
@property (nonatomic, assign) CGSize itemSize;
/**
 item 的类型
 */
@property (nonatomic, assign) JHDataModelType itemType;
/**
 item 头部高度
 */
@property(nonatomic,assign)CGSize headerSize;

/**
 item 尾部高度
 */
@property(nonatomic,assign)CGSize footerSize;

/**
 上左下右间距
 */
@property(nonatomic,assign)UIEdgeInsets edgeInsets;

/**
 数量
 */
@property(nonatomic,assign)NSInteger count;

/**
 item数据
 */
@property(nonatomic,strong)NSArray *GroupArray;

/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 存字典模型的构造方法   注意数据类型是字典
 
 @param dic         数据
 @param rowHeight   行高
 @param identifier  复用标识
 @return self
 */
- (instancetype)initWithDic:(NSDictionary *)dic rowHeight:(CGFloat)rowHeight identifier:(NSString *)identifier;


/**
 存字典模型的构造方法  注意数据类型是字典
 
 @param dic         数据
 @param itemSize    item大小
 @param identifier  复用标识
 @return self
 */
- (instancetype)initWithDic:(NSDictionary *)dic itemSize:(CGSize)itemSize identifier:(NSString *)identifier;


/**
 字典转模型方法 无实际意义，由子类重写   （依个人习惯用哪个第三方转模型）
 */
+ (instancetype)setupDataWithDic:(NSDictionary *)dic;

/**
 请求数据方法，无实际意义，由子类重写
 */
+ (void)requestDataWithParameter:(NSDictionary *)parameter inView:(UIView *)view scrollView:(UIScrollView *)scrollView success:(void(^)(NSArray *result))success failure:(void(^)(NSError *error))failure;
@end
