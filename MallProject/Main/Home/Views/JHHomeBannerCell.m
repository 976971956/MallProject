//
//  JHHomeBannerCell.m
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import "JHHomeBannerCell.h"

@interface JHHomeBannerCell()

@end

@implementation JHHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    NSMutableArray *imageArr = [NSMutableArray array];
    for (JHHomeRowModel *model in imageArray) {
        [imageArr addObject:model.Image];
    }
    self.pagedView.minimumPageAlpha = 0.3;//非当前页的透明比例
    self.pagedView.leftRightMargin = 0;//左右间距
    self.pagedView.topBottomMargin = 0;
    self.pagedView.hiddenPageControll = YES;
    self.pagedView.orginPageCount = self.imageArray.count;//原始页数
    self.pagedView.isOpenAutoScroll = YES;//是否开启自动滚动
    self.pagedView.autoTime = 2.0;//设置定时器秒数
    self.pagedView.isCarousel = YES;//是否开启无限轮播
    self.pagedView.orientation = NewPagedFlowViewOrientationHorizontal;//横向纵向
    
    //    pageFlowView.urlImageDataSource = self.imageArray;//传入网络数据
    self.pagedView.urlImageDataSource = imageArr;//传入网络数据
    
    self.pagedView.imgProportion = 10/16.0;//设置图片比例
    self.pagedView.cornerRadius = 5;//设置圆角
    self.pagedView.contentMode = UIViewContentModeScaleToFill;
    [self.pagedView reloadData];//设置完数据刷新数据
}
@end
