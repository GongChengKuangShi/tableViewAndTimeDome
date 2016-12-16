//
//  BillEmptyCell.m
//  MangoFinance
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 wim. All rights reserved.
//

#import "BillEmptyCell.h"

@implementation BillEmptyCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.topImageView.image = [UIImage imageNamed:@"bill_empty_image.png"];
    self.titleLabel.text = @"暂无相关记录...";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
