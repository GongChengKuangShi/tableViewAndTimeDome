//
//  NSDate+Tools.h
//  TimeToScreenView
//
//  Created by 叶明君 on 16/12/13.
//  Copyright © 2016年 叶明君. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDate (Tools)

/**
 *  获取世纪
 */
- (NSInteger)era;
/**
 *  获取年
 */
- (NSInteger)year;
/**
 *  获取月
 */
- (NSInteger)month;
/**
 *  获取日
 */
- (NSInteger)day;
/**
 *  获取时
 */
- (NSInteger)hour;
/**
 *  获取分
 */
- (NSInteger)minute;
/**
 *  获取秒
 */
- (NSInteger)second;

- (NSInteger)weekday;
- (NSInteger)weekdayOrdinal;
- (NSInteger)quarter;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;
- (NSInteger)yearForWeekOfYear;
- (NSInteger)daysInMonth;
- (NSInteger)dayOfYear;
- (NSInteger)daysInYear;
/**
 *  距离当前时间多少月
 */
- (NSUInteger)monthsAgo;
/**
 *  距离当前时间多少天
 */
- (NSUInteger)daysAgo;
/**
 *  距离当前时间多少小时
 */
- (NSUInteger)hoursAgo;
/**
 *  距离当前时间多少分钟
 */
- (NSUInteger)minutesAgo;

/**
 *  距离当前时间多少秒
 */
- (NSUInteger)secondsAgo;

#pragma mark Date By Adding
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;

#pragma mark - formatted with Format
- (NSString *)formattedDateWithFormat:(NSString *)format;
- (NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
- (NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale;
+ (NSString *)formattedDateWithFormat:(NSString *)format timeInterval:(NSTimeInterval)intercal;
/**
 *  返回格式化日期字符串
 *  @param format    格式化字符串 eg:yyyy-MM-dd
 *  @param timeZone  时区
 *  @param locale    语言环境
 */
- (NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
/**
 *  通过日期返回固定字符串 如果是一月内返回 月日  如果是今年 返回月 其他返回 年月
 *
 *  @param date     日期
 *  @param flag     是否精确到日
 */
+ (NSString *)stringForDisplayFromDate:(NSDate *)date
                               unitDay:(BOOL)flag;
/**
 *  通过日期返回固定字符串 如果是一月内返回 月日  如果是今年 返回月 其他返回 年月
 *
 *  @param interval     时间戳
 *  @param flag         是否精确到日
 */
+ (NSString *)stringForDisplayFromInterval:(NSTimeInterval)interval unitDay:(BOOL)flag;

#pragma mark - Time Ago
+ (NSString*)timeAgoSinceDate:(NSDate*)date;
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date;
+ (NSString *)weekTimeAgoSinceDate:(NSDate *)date;

- (NSString *)timeAgoSinceDate:(NSDate *)date;
- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates;
- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates numericTimes:(BOOL)useNumericTimes;

- (NSString *)shortTimeAgoSinceDate:(NSDate *)date;
- (NSString *)weekTimeAgoSinceDate:(NSDate *)date;


@end
