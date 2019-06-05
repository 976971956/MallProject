//
//  JHHomeModel.m
//  MallProject
//
//  Created by 江湖 on 2019/6/4.
//  Copyright © 2019 江湖. All rights reserved.
//

#import "JHHomeModel.h"

@implementation JHHomeModel
+ (NSDictionary *)objectClassInArray{
    return @{ @"TopSwap" : @"JHHomeRowModel",@"Floors" : @"JHHomeFloorsModel",@"activityFloors" : @"JHHomeFloorsModel"};
}
- (void) setingSectionDatas:(JHHomeModel *)homeModel{
    NSMutableArray *group = [NSMutableArray array];
    JHDataModel *bannerModel = [[JHDataModel alloc]init];
    bannerModel.count = 1;
    bannerModel.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    bannerModel.itemType = JHDataModelType1;
    bannerModel.headerSize = CGSizeZero;
    bannerModel.footerSize = CGSizeZero;
    bannerModel.cellID = bannerCellID;
    bannerModel.itemSize = CGSizeMake(ScreenW, ScreenW*340/720);
    bannerModel.GroupArray = homeModel.TopSwap;
    [group addObject:bannerModel];
    for (int i = 0; i < homeModel.Floors.count; i++) {
        JHHomeFloorsModel *floor = homeModel.Floors[i];
        if ([floor.Type integerValue] == 104) {//商品
            JHDataModel *rowModel = [[JHDataModel alloc]init];
            rowModel.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            
            rowModel.itemType = JHDataModelType2;
            rowModel.count = floor.Cells.count;
            rowModel.headerSize = CGSizeMake(ScreenW, 44);
            rowModel.footerSize = CGSizeZero;
            rowModel.cellID = productCellID;
            rowModel.itemSize = CGSizeMake((ScreenW-40)/2, (ScreenW-40)/2+120);
            for (int j = 0; j<floor.Cells.count; j++) {
                JHHomeRowModel *rowModel = floor.Cells[j];
                rowModel.cellSize = CGSizeMake((ScreenW-40)/2, (ScreenW-40)/2+120);
            }
            rowModel.GroupArray = floor.Cells;
            [group addObject:rowModel];
        }
    }
    
    self.sectionArray = group;
}
@end

@implementation JHHomeBannerModel

@end

@implementation JHHomeFloorsModel

+ (NSDictionary *)objectClassInArray{
    return @{ @"Cells" : @"JHHomeRowModel"};
}

@end

@implementation JHHomeRowModel

@end




