//
//  HYUtility.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYUtility.h"


@implementation HYUtility
+ (void)saveCacheData:(id)obj withKey:(NSString *)keyName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:keyName];
    [userDefaults synchronize];
    
}

+ (id)loadCacheData:(NSString *)keyName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:keyName];
}

+ (void)clearCacheData:(NSString *)keyName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:keyName];
    [userDefaults synchronize];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format timeZone:(NSTimeZone *)zone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (zone)
        [formatter setTimeZone:zone];
    else
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFrom:(NSString *)strDate withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:strDate];
}

+ (NSString *)getContactDay:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSUInteger countNowDay = [cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:now];
    NSUInteger countDateDay = [cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    if (countNowDay == countDateDay) return  @"今天"; //同一天
    
    NSUInteger countNowWeek = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:now];
    NSUInteger countDateWeek = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *component = [cal components:unitFlags fromDate:date];
    if (countNowWeek == countDateWeek) { //同一天
        NSArray *weekday = [NSArray arrayWithObjects:@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        return  [weekday objectAtIndex:([component weekday]-1)];
    }
    return [NSString stringWithFormat:@"%ld/%ld/%ld",[component year] - 2000, [component month], [component day]];
}

+(NSString *)getContactDayFormatMonthDay:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSUInteger countNowDay = [cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:now];
    NSUInteger countDateDay = [cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    if (countNowDay == countDateDay) return  @"今天"; //同一天
    
    NSUInteger countNowWeek = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:now];
    NSUInteger countDateWeek = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *component = [cal components:unitFlags fromDate:date];
    if (countNowWeek == countDateWeek) { //同一天
        NSArray *weekday = [NSArray arrayWithObjects:@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        return  [weekday objectAtIndex:([component weekday]-1)];
    }
    return [NSString stringWithFormat:@"%ld月%ld日",[component month], [component day]];
}

+ (NSString *)getContactTime:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *component = [cal components:unitFlags fromDate:date];
    
    return [NSString stringWithFormat:@"%ld:%02ld",[component hour], (long)[component minute]];
}

+ (BOOL)isLocationServiceEnabled {
    if (![CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)    {
        return YES;
    }
    return NO;
}


+ (NSString *) getNonNullString:(NSString *)string {
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}

/*
 *网络加载
 */
//static YKTLoadingView *sharedLoadingView = nil;

+ (void)showLoadingView {
//    if (sharedLoadingView == nil) {
//        sharedLoadingView = [[YKTLoadingView alloc] init];
//    }
//    [sharedLoadingView showView];
}

+ (void)dismissLoadingView {
//    if (sharedLoadingView == nil) {
//        sharedLoadingView = [[YKTLoadingView alloc] init];
//    }
//    [sharedLoadingView dismissView];
    
}

/*
 *是否包含Emoji表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
@end
