//
//  NSString+Utils.m
//  MangoFinance
//
//  Created by 叶明君 on 16/9/6.
//  Copyright © 2016年 wim. All rights reserved.
//

#import "NSString+Util.h"



@implementation NSString (Util)
- (NSString *)stringFormatterCurrencyStyle {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    return formattedNumberString;
}

- (NSString *)timeWithTimeIntervalStringToDay {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    long long num  = 0;
    num = [self longLongValue] / 1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    return [formatter stringFromDate:confromTimesp];
}

- (NSString *)timeString {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    long long num  = 0;
    num = [self longLongValue] / 1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    return [formatter stringFromDate:confromTimesp];
}

- (NSString *)timeWithTimeIntervalStringToSeconds {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    long long num  = 0;
    num = [self longLongValue] / 1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    return [formatter stringFromDate:confromTimesp];
}

@end
