//
//  BaseTableView.h
//  TableViewGroup
//
//  Created by 叶明君 on 16/12/15.
//  Copyright © 2016年 叶明君. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView didSelectHeaderView:(UIView *)headerView section:(NSInteger)section;

@end

#define DIC_EXPANDED @"expanded"

typedef NS_ENUM(NSInteger,UITableViewsHeadStyle) {
    TableViewsHeadCustom,
    TableViewsHeadExpanded,
};

@interface BaseTableView : UITableView

@property (weak, nonatomic) id<BaseTableViewDelegate> headDeleagate;
@property (assign, nonatomic) UITableViewsHeadStyle headViewStyle;

- (NSInteger)isExpanded:(NSInteger)section;
- (UIView *)customTablevHeaderView:(UIView *)customView section:(NSInteger)section style:(UITableViewsHeadStyle)style;

@end
