//
//  UITableViewCell+JHTableViewCell.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/26.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (JHTableViewCell)

- (void)paddingDataModel:(JHDataModel *)model indexPath:(NSIndexPath *)indexPath delegate:(id)delegate;

@end
