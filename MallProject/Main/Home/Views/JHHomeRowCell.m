//
//  JHHomeRowCell.m
//  MallProject
//
//  Created by 江湖 on 2019/6/5.
//  Copyright © 2019 江湖. All rights reserved.
//

#import "JHHomeRowCell.h"
#import "NSString+Operation.h"
@interface JHHomeRowCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *shopTypeLab;

@end

@implementation JHHomeRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(JHHomeRowModel *)model{
    _model = model;
    [self.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:model.Image]];
    self.titleLab.text = model.Name;
    
    NSArray *array = model.ActionValue;
    NSString *temp = @"";
    for (NSDictionary *dict in array) {
        NSString *key = [dict objectForKey:@"Key"];
        NSString *string = [dict objectForKey:@"Value"];
        if ([key isEqualToString:@"Price"]) {//价格
            if ([NSString isPureString:string]) {
                temp = string;
            }
            
            break;
        }
    }
    ;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",temp.numType(2,NSRoundDown)];
    self.shopTypeLab.text = [NSString stringWithFormat:@" %@ ",model.label];
}
@end
