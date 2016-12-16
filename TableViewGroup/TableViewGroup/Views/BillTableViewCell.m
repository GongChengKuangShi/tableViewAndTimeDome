//
//  BillTableViewCell.m
//  MangoFinance
//
//  Created by 叶明君 on 16/7/27.
//  Copyright © 2016年 wim. All rights reserved.
//

#import "BillTableViewCell.h"

@interface BillTableViewCell ()

@property (copy, nonatomic) NSString *amountString;
@property (strong, nonatomic) NSMutableArray *timeArray;

@end

@implementation BillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark set timeArray
- (NSMutableArray *)timeArray {
    if (!_timeArray) {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
}

#pragma mark cellLoadData

- (void)setDate:(NSDictionary *)dictionary source:(CellDataSource)source {
    if (source == DataFromBillDetail) {
        [self loadTitleLabelWithDictionary:dictionary];
        NSString *dateString = [NSString stringWithFormat:@"%@",[dictionary safeObjectForKey:@"ctime"]];
        NSString *statuString = [NSDate stringForDisplayFromInterval:[dateString doubleValue] / 1000 unitDay:YES];
        self.stateLabel.text = [dateString timeWithTimeIntervalStringToSeconds];
//        NSDate *inputDate = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue] / 1000];
//        NSString *dateS = [inputDate formattedDateWithFormat:@"MM-dd"];
        NSString *remarkString = [dictionary safeObjectForKey:@"remark"];
        NSDictionary *remarkDic = [remarkString dictionaryWithJsonString];
        self.remarkLabel.text = [remarkDic safeObjectForKey:@"message"];
        [self loadDateLabelWithString:statuString];
    }
}


#pragma mark load moneyLabel && titleLabel
- (void)loadTitleLabelWithDictionary:(NSDictionary *)dictionary {
    self.amountString = [NSString stringWithFormat:@"%@",[dictionary safeObjectForKey:@"amount"]];
    NSString *ctypeString = [NSString stringWithFormat:@"%@",[dictionary safeObjectForKey:@"ctype"]];
    [self setTypeWithCtype:ctypeString];
}

- (void)setTypeWithCtype:(NSString *)ctype {
    if ([ctype isEqualToString:@"1"]) {
        [self loadLabelWithString:@"收入" textColor:UIColorFromRGB(0xf15b1c) type:CtypeTypeAdd];
    }
    if ([ctype isEqualToString:@"2"]) {
        [self loadLabelWithString:@"支出" textColor:UIColorFromRGB(0x16b500) type:CtypeTypeReduction];
    }
    if ([ctype isEqualToString:@"3"]) {
        [self loadLabelWithString:@"冻结" textColor:UIColorFromRGB(0x999999) type:CtypeTypeNone];
    }
    if ([ctype isEqualToString:@"4"]) {
        [self loadLabelWithString:@"解冻" textColor:UIColorFromRGB(0x333333) type:CtypeTypeNone];
    }
}

- (void)loadLabelWithString:(NSString *)titleString textColor:(UIColor *)color type:(CtypeType)type{
    if (type == CtypeTypeAdd) {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",[self.amountString stringFormatterCurrencyStyle]];
    } else if (type == CtypeTypeReduction) {
        self.moneyLabel.text = [NSString stringWithFormat:@"-%@",[self.amountString stringFormatterCurrencyStyle]];
    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"%@",[self.amountString stringFormatterCurrencyStyle]];
    }
    self.titleLabel.text = titleString;
    self.moneyLabel.textColor = color;
}

#pragma mark load dateLabel
- (void)loadDateLabelWithString:(NSString *)string {
    self.dateLabel.text = string;
    if ([string isEqualToString:@"今天"]) {
        [self setCellType:BillListFirst];
    } else {
        [self setCellType:BillListAddTime];
    }
}

- (void)setCellType:(BillListType)cellType {
    switch (cellType) {
        case BillListFirst:
            [self setTopImageBool:YES signImage:@"profile_bill_cell_solid.png" bottomImage:NO];
            break;
        case BillListAddTime:
            [self setTopImageBool:NO signImage:@"profile_bill_cell_null.png" bottomImage:NO];
            break;
        case BillListNotTime:
            [self setTopImageBool:NO signImage:@"" bottomImage:NO];
            break;
        case BillListLast:
            [self setTopImageBool:NO signImage:@"profile_bill_cell_solid.png" bottomImage:YES];
            break;
        case BillListHideline:
            [self setTopImageBool:YES signImage:@"profile_bill_cell_solid.png" bottomImage:YES];
            break;
        default:
            break;
    }
}

- (void)setTopImageBool:(BOOL)top signImage:(NSString *)imageString bottomImage:(BOOL)bottom {
    self.topImage.hidden = top;
    self.signImage.image = [UIImage imageNamed:imageString];
    self.bottomIamge.hidden = bottom;
}




@end
