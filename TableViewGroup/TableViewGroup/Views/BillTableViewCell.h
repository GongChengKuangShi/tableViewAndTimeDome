//
//  BillTableViewCell.h
//  MangoFinance
//
//  Created by 叶明君 on 16/7/27.
//  Copyright © 2016年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BillTableViewCell : UITableViewCell

typedef NS_ENUM(NSInteger, BillListType) {
    BillListFirst,
    BillListAddTime,
    BillListNotTime,
    BillListLast,
    BillListHideline
};



typedef NS_ENUM(NSInteger, CtypeType) {
    CtypeTypeAdd,
    CtypeTypeReduction,
    CtypeTypeNone,
};

typedef NS_ENUM(NSInteger, CellDataSource) {
    DataFromAwardDetail,
    DataFromBillDetail,
};

@property (weak, nonatomic) IBOutlet UIImageView *signImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomIamge;
//@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, assign) BillListType cellType;
@property (assign, nonatomic) CtypeType ctypeType;


- (void)setDate:(NSDictionary *)dictionary source:(CellDataSource)source;
@end
