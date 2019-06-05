//
//  JHBaseTableViewController.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/26.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseTableViewController : JHBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (void)removeRefresh;

- (void)removeHeaderRefresh;

- (void)removeFooterRefresh;

- (void)reloadData;

- (void)reloadDataWithArray:(NSArray *)data;

- (void)reloadDataWithArray:(NSArray *)data needNoDataBtn:(BOOL)isNeed;

@end

