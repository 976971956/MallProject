//
//  JHBaseTableCell.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/26.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHBaseTableCellDelegate <NSObject>

@optional

/**
 刷新某一行的数据
 */
- (void)reloadWithModel:(JHDataModel *)model indexPath:(NSIndexPath *)indexPath;


/**
 增加一行
 
 @param model 增加的数据模型
 @param indexPath 增加的位置
 */
- (void)addWithModel:(JHDataModel *)model indexPath:(NSIndexPath *)indexPath;


/**
 删除一行
 
 @param model 删除的数据模型
 @param indexPath 删除的位置
 */
- (void)removeWithModel:(JHDataModel *)model indexPath:(NSIndexPath *)indexPath;


@end

@interface JHBaseTableCell : UITableViewCell

@property (nonatomic, weak) id<JHBaseTableCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
