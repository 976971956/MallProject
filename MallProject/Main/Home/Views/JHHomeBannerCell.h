//
//  JHHomeBannerCell.h
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPagedFlowView.h"
#import "JHHomeModel.h"
@interface JHHomeBannerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NewPagedFlowView *pagedView;

@property (nonatomic, strong)NSArray *imageArray;
@end
