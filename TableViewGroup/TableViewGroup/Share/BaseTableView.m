//
//  BaseTableView.m
//  TableViewGroup
//
//  Created by mgjr on 16/12/15.
//  Copyright © 2016年 mgjr. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()

@property (strong, nonatomic) NSMutableDictionary *expandeds;

@end

@implementation BaseTableView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (NSMutableDictionary *)expandeds {
    if (!_expandeds) {
        _expandeds = [NSMutableDictionary dictionary];
    }
    return _expandeds;
}

- (NSInteger)isExpanded:(NSInteger)section{
    NSString *dicName = [NSString stringWithFormat:@"%@%ld",DIC_EXPANDED,(long)section];
    NSInteger expanded = [[self.expandeds objectForKey:dicName] intValue];
    return expanded;
}

- (void)collapseOrExpand:(NSInteger)section{
    NSString *dicName = [NSString stringWithFormat:@"%@%ld",DIC_EXPANDED,(long)section];
    int expanded = [[self.expandeds objectForKey:dicName] intValue];
    if (expanded)
        [_expandeds setValue:[NSNumber numberWithInt:0]forKey:dicName];
    else
        [_expandeds setValue:[NSNumber numberWithInt:1]forKey:dicName];
}

#pragma mark Delegate bank
// UITableViewDelegate
- (UIView *)customTablevHeaderView:(UIView *)customView section:(NSInteger)section style:(UITableViewsHeadStyle)style {
    UIView *headerView = customView;
    if (!headerView) {
        headerView = [[UIView alloc]init];
    }
    headerView.userInteractionEnabled = YES;
    if (style == TableViewsHeadExpanded) {
        headerView.tag = 100 + section;
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(gestureRecognizer:)];
        [headerView addGestureRecognizer:gestureRecognizer];
    }
    return headerView;
}

- (void)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer{
    NSInteger section = gestureRecognizer.view.tag - 100;
    [self collapseOrExpand:section];
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    if ([self.headDeleagate respondsToSelector:@selector(tableView:didSelectHeaderView:section:)]) {
        [self.headDeleagate tableView:self didSelectHeaderView:gestureRecognizer.view section:section];
    }
}

@end
