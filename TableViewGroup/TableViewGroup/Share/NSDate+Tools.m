//
//  NSDate+Tools.m
//  TimeToScreenView
//
//  Created by 叶明君 on 16/12/13.
//  Copyright © 2016年 叶明君. All rights reserved.
//

#import "NSDate+Tools.h"

typedef NS_ENUM(NSUInteger, DateComponent){
    DateComponentEra,
    DateComponentYear,
    DateComponentMonth,
    DateComponentDay,
    DateComponentHour,
    DateComponentMinute,
    DateComponentSecond,
    DateComponentWeekday,
    DateComponentWeekdayOrdinal,
    DateComponentQuarter,
    DateComponentWeekOfMonth,
    DateComponentWeekOfYear,
    DateComponentYearForWeekOfYear,
    DateComponentDayOfYear
};

typedef NS_ENUM(NSUInteger, DateAgoUnitFlag){
    YearsAgo,
    MonthsAgo,
    WeeksAgo,
    DaysAgo,
    HoursAgo,
    MinutesAgo,
    SecondsAgo
};

typedef NS_ENUM(NSUInteger, DateAgoFormat){
    DateAgoLong,
    DateAgoLongUsingNumericDatesAndTimes,
    DateAgoLongUsingNumericDates,
    DateAgoLongUsingNumericTimes,
    DateAgoShort,
    DateAgoWeek,
};

static const unsigned int allCalendarUnitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear;

static NSCalendar *implicitCalendar = nil;

@implementation NSDate (Tools)

+ (void)load {
    implicitCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

#pragma mark Component Calendar
- (NSInteger)era{
    return [self componentForDate:self type:DateComponentEra calendar:nil];
}

- (NSInteger)year{
    return [self componentForDate:self type:DateComponentYear calendar:nil];
}

- (NSInteger)month{
    return [self componentForDate:self type:DateComponentMonth calendar:nil];
}

- (NSInteger)day{
    return [self componentForDate:self type:DateComponentDay calendar:nil];
}

- (NSInteger)hour{
    return [self componentForDate:self type:DateComponentHour calendar:nil];
}

- (NSInteger)minute{
    return [self componentForDate:self type:DateComponentMinute calendar:nil];
}

- (NSInteger)second{
    return [self componentForDate:self type:DateComponentSecond calendar:nil];
}

- (NSInteger)weekday{
    return [self componentForDate:self type:DateComponentWeekday calendar:nil];
}

- (NSInteger)weekdayOrdinal{
    return [self componentForDate:self type:DateComponentWeekdayOrdinal calendar:nil];
}


- (NSInteger)quarter{
    return [self componentForDate:self type:DateComponentQuarter calendar:nil];
}


- (NSInteger)weekOfMonth{
    return [self componentForDate:self type:DateComponentWeekOfMonth calendar:nil];
}


- (NSInteger)weekOfYear{
    return [self componentForDate:self type:DateComponentWeekOfYear calendar:nil];
}


- (NSInteger)yearForWeekOfYear{
    return [self componentForDate:self type:DateComponentYearForWeekOfYear calendar:nil];
}

- (NSInteger)daysInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:self];
    return days.length;
}

- (NSInteger)dayOfYear{
    return [self componentForDate:self type:DateComponentDayOfYear calendar:nil];
}

-(NSInteger)daysInYear{
    if (self.isInLeapYear) {
        return 366;
    }
    return 365;
}

#pragma mark - Date Ago
- (NSUInteger)monthsAgo {
    return [self dateFrom:self type:MonthsAgo calendar:nil];
}

- (NSUInteger)daysAgo {
    return [self dateFrom:self type:DaysAgo calendar:nil];
}

- (NSUInteger)hoursAgo {
    return [self dateFrom:self type:HoursAgo calendar:nil];
}

- (NSUInteger)minutesAgo {
    return [self dateFrom:self type:MinutesAgo calendar:nil];
}

- (NSUInteger)secondsAgo {
    return [self dateFrom:self type:SecondsAgo calendar:nil];
}

#pragma mark - Date Adding
- (NSDate *)dateByAddingYears:(NSInteger)years{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}


#pragma mark - Formatted with Format
-(NSString *)formattedDateWithFormat:(NSString *)format{
    return [self formattedDateWithFormat:format timeZone:[NSTimeZone systemTimeZone] locale:[NSLocale autoupdatingCurrentLocale]];
}

-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone{
    return [self formattedDateWithFormat:format timeZone:timeZone locale:[NSLocale autoupdatingCurrentLocale]];
}
   
-(NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale{
    return [self formattedDateWithFormat:format timeZone:[NSTimeZone systemTimeZone] locale:locale];
}

- (NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

+ (NSString *)formattedDateWithFormat:(NSString *)format timeInterval:(NSTimeInterval)intercal {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intercal];
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

#pragma mark - Today
+ (NSString *)stringForDisplayFromInterval:(NSTimeInterval)interval
                                  unitDay:(BOOL)flag {
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:interval];
    return [NSDate stringForDisplayFromDate:date unitDay:flag];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date unitDay:(BOOL)flag {
    NSDate *today = [NSDate date];
    if (flag) {
        if ([today day] - [date day] == 0) {
            return @"今天";
        } else if ([today day] - [date day] == 1) {
            return @"昨天";
        }
        return [NSString stringWithFormat:@"%ld-%ld",(long)[date month],(long)[date day]];
    } else {
        if ([today year] - [date year] == 0 && [today month] - [date month] == 0) {
            return @"本月";
        }
        else if ([today year] - [date year] == 0) {
            return [NSString stringWithFormat:@"%ld月",(long)[date month]];
        }
        return [NSString stringWithFormat:@"%ld年%ld月",(long)[date year],(long)[date month]];
    }
}

#pragma mark - Time Ago
+ (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [date timeAgoSinceDate:[NSDate date]];
}

+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date{
    return [date shortTimeAgoSinceDate:[NSDate date]];
}

+ (NSString*)weekTimeAgoSinceDate:(NSDate*)date{
    return [date weekTimeAgoSinceDate:[NSDate date]];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date numericDates:NO];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates{
    return [self timeAgoSinceDate:date numericDates:useNumericDates numericTimes:NO];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates numericTimes:(BOOL)useNumericTimes{
    if (useNumericDates && useNumericTimes) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDatesAndTimes];
    } else if (useNumericDates) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDates];
    } else if (useNumericTimes) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDates];
    } else {
        return [self timeAgoSinceDate:date format:DateAgoLong];
    }
}

- (NSString *)shortTimeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date format:DateAgoShort];
}

- (NSString *)weekTimeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date format:DateAgoWeek];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date format:(DateAgoFormat)format {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSUInteger upToHours = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour;
    NSDateComponents *difference = [calendar components:upToHours fromDate:earliest toDate:latest options:0];
    if (difference.hour < 24) {
        if (difference.hour >= 1) {
            return [self localizedStringFor:format unitFlag:HoursAgo value:difference.hour];
        } else if (difference.minute >= 1) {
            return [self localizedStringFor:format unitFlag:MinutesAgo value:difference.minute];
        } else {
            return [self localizedStringFor:format unitFlag:SecondsAgo value:difference.second];
        }
    } else {
        NSUInteger bigUnits = NSCalendarUnitTimeZone | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth | NSCalendarUnitYear;
        NSDateComponents *components = [calendar components:bigUnits fromDate:earliest];
        earliest = [calendar dateFromComponents:components];
        components = [calendar components:bigUnits fromDate:latest];
        latest = [calendar dateFromComponents:components];
        difference = [calendar components:bigUnits fromDate:earliest toDate:latest options:0];
        if (difference.year >= 1) {
            return [self localizedStringFor:format unitFlag:YearsAgo value:difference.year];
        } else if (difference.month >= 1) {
            return [self localizedStringFor:format unitFlag:MonthsAgo value:difference.month];
        } else if (difference.weekOfYear >= 1) {
            return [self localizedStringFor:format unitFlag:WeeksAgo value:difference.weekOfYear];
        } else {
            return [self localizedStringFor:format unitFlag:DaysAgo value:difference.day];
        }
    }
}

- (NSString *)localizedStringFor:(DateAgoFormat)format unitFlag:(DateAgoUnitFlag)flag value:(NSInteger)value {
    BOOL isShort = format == DateAgoShort;
    BOOL isNumericDate = format == DateAgoLongUsingNumericDates || format == DateAgoLongUsingNumericDatesAndTimes;
    BOOL isNumericTime = format == DateAgoLongUsingNumericTimes || format == DateAgoLongUsingNumericDatesAndTimes;
    BOOL isWeek =  format == DateAgoWeek;
    switch (flag) {
        case YearsAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld年",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld年前",(long)value];
            } else if (isNumericDate) {
                return  @"1年前";
            } else {
                return @"去年";
            }
        case MonthsAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld月",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld个月前",(long)value];
            } else if (isNumericDate) {
                return @"1个月前";
            } else {
                return @"上个月";
            }
        case WeeksAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld星期",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld星期前",(long)value];;
            } else if (isNumericDate) {
                return @"1星期前";
            } else {
                return @"上星期";
            }
        case DaysAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld天",(long)value];
            } else if (value >= 2) {
                if (isWeek && value <= 7) {
                    NSDateFormatter *dayDateFormatter = [[NSDateFormatter alloc]init];
                    dayDateFormatter.dateFormat = @"EEE";
                    NSString *eee = [dayDateFormatter stringFromDate:self];
                    return eee;
                }
                return [NSString stringWithFormat:@"%ld天前",(long)value];
            } else if (isNumericDate) {
                return @"1天前";
            } else {
                return @"昨天";
            }
        case HoursAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld小时",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld小时前",(long)value];
            } else if (isNumericTime) {
                return @"1小时前";
            } else {
                return @"1小时前";
            }
        case MinutesAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld分钟",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld分钟前",(long)value];
            } else if (isNumericTime) {
                return @"1分钟前";
            } else {
                return @"1分钟前";
            }
        case SecondsAgo:
            if (isShort) {
                return [NSString stringWithFormat:@"%ld秒",(long)value];
            } else if (value >= 2) {
                return [NSString stringWithFormat:@"%ld秒前",(long)value];
            } else if (isNumericTime) {
                return @"1秒前";
            } else {
                return @"刚刚";
            }
    }
    return nil;
}

#pragma mark - Private
// 两个时间的间隔
- (NSInteger)dateFrom:(NSDate *)date type:(DateAgoUnitFlag)component calendar:(NSCalendar *)calendar {
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    unsigned int unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *dateComponents = [calendar components:unitFlags
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    switch (component) {
        case YearsAgo:
            return [dateComponents year];
        case MonthsAgo:
            return [dateComponents month];
        case DaysAgo:
            return [dateComponents day];
        case HoursAgo:
            return [dateComponents hour];
        case MinutesAgo:
            return [dateComponents minute];
        case SecondsAgo:
            return [dateComponents second];
        default:
            break;
    }
    return 0;
}

// 获取时间
-(NSInteger)componentForDate:(NSDate *)date type:(DateComponent)component calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    unsigned int unitFlags = 0;
    if (component == DateComponentYearForWeekOfYear) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
    }
    else {
        unitFlags = allCalendarUnitFlags;
    }
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    switch (component) {
        case DateComponentEra:
            return [dateComponents era];
        case DateComponentYear:
            return [dateComponents year];
        case DateComponentMonth:
            return [dateComponents month];
        case DateComponentDay:
            return [dateComponents day];
        case DateComponentHour:
            return [dateComponents hour];
        case DateComponentMinute:
            return [dateComponents minute];
        case DateComponentSecond:
            return [dateComponents second];
        case DateComponentWeekday:
            return [dateComponents weekday];
        case DateComponentWeekdayOrdinal:
            return [dateComponents weekdayOrdinal];
        case DateComponentQuarter:
            return [dateComponents quarter];
        case DateComponentWeekOfMonth:
            return [dateComponents weekOfMonth];
        case DateComponentWeekOfYear:
            return [dateComponents weekOfYear];
        case DateComponentYearForWeekOfYear:
            return [dateComponents yearForWeekOfYear];
        case DateComponentDayOfYear:
            return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
        default:
            break;
    }
    return 0;
}

- (BOOL)isInLeapYear {
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *dateComponents = [calendar components:allCalendarUnitFlags fromDate:self];
    
    if (dateComponents.year % 400 == 0){
        return YES;
    }
    else if (dateComponents.year % 100 == 0){
        return NO;
    }
    else if (dateComponents.year % 4 == 0){
        return YES;
    }
    return NO;
}

+ (NSCalendar *)implicitCalendar {
    return implicitCalendar;
}

@end
