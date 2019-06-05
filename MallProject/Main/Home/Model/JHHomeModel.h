//
//  JHHomeModel.h
//  MallProject
//
//  Created by 江湖 on 2019/6/4.
//  Copyright © 2019 江湖. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *bannerCellID = @"bannerCellID";
static NSString *productCellID = @"productCellID";

@class JHHomeFloorsModel;
#pragma mark  --JHHomeModel
@interface JHHomeModel : NSObject

@property(nonatomic,strong)NSArray *TopSwap;//头部图片数组

@property(nonatomic,strong)NSArray *TopNav;//分类数据

@property(nonatomic,strong)NSArray *Notice;

@property(nonatomic,copy)NSString *rateProfit;

@property(nonatomic,strong)NSArray *Floors;

@property(nonatomic,strong)NSMutableArray *sectionArray;

@property(nonatomic,strong)NSArray *HotKeyWords;

@property(nonatomic, strong)NSArray *StartAdverts;

@property(nonatomic,copy)NSString *UpdateDateTime;
@property(nonatomic,copy)NSString *Ver;
@property(nonatomic,copy)NSString *VerDownloadUrl;
@property(nonatomic,copy)NSString *VerNo;
@property(nonatomic,copy)NSString * VerUpContent;
@property(nonatomic,copy)NSString * redGiftAmount;
@property(nonatomic, strong) NSArray *activityFloors;

- (void)setingSectionDatas:(JHHomeModel *)homeModel;
@end

#pragma mark  --JHHomeBannerModel

@interface JHHomeBannerModel : NSObject

@end


#pragma mark  --JHHomeFloorsModel

@interface JHHomeFloorsModel : NSObject

@property(nonatomic,copy)NSString *Name;

@property(nonatomic,copy)NSString *TitleImage;

@property(nonatomic,assign)int hideTitle;

@property(nonatomic,copy)NSString *Style;

@property(nonatomic,assign)int Sort;

@property(nonatomic,copy)NSString *Type;

@property(nonatomic,copy)NSString *Columns;

@property(nonatomic,copy)NSArray *Cells;

@property(nonatomic,copy)NSDictionary *More;

@end

#pragma mark  --JHHomeRowModel

@interface JHHomeRowModel : NSObject

@property(nonatomic,copy)NSString *Name;

@property(nonatomic,copy)NSString *Detail;

@property(nonatomic,copy)NSString *Image;

@property(nonatomic,copy)NSString *Action;

@property(nonatomic,copy)NSArray *ActionValue;

@property(nonatomic,copy)NSString *Price;

@property(nonatomic,copy)NSString *OriginalPrice;

@property(nonatomic,copy)NSString *Rebate;

@property (nonatomic, copy) NSString *tub;//用户行为轨迹记录设计

//活动信息的数组
@property(nonatomic, strong) NSArray *activityInfos;

//尺寸
@property(nonatomic,assign)CGSize cellSize;

@property(nonatomic,copy)NSString *label; // 商家标签（可空）

@property(nonatomic, assign) BOOL isfreeshipping; // 是否包邮

@property(nonatomic, assign) BOOL isFreeShipping; // 是否包邮(首页)

@property (nonatomic, assign) CGFloat vipDisPrice; // 会员折扣价格,大于0才有效

@property (nonatomic, copy) NSString *isvip; // 是否有会员折扣(0-没有／1-有)

@property (nonatomic ,copy)  NSString *vipDownPrice;// 会员折扣减少金额

@property (nonatomic, assign) BOOL vipExclusive; // 针对秒赠商品，是否会员专属


@property(nonatomic, strong)NSIndexPath *indexPath; // 用来记载index,用来回调时候记住当前的下标

// 商品楼层cell辅助计算高度(首页界面)
@property (nonatomic, assign) CGFloat bigImageListHeight; // 大图模式

@end

