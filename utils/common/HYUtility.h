//
//  HYUtility.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HYUtility : NSObject
/*
 *缓存数据读取与设置
 */
+ (void)saveCacheData:(id)obj withKey:(NSString *)keyName;

+ (id)loadCacheData:(NSString *)keyName;

+ (void)clearCacheData:(NSString *)keyName;


/*
 *获取通话、短信时的日期时间信息
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format timeZone:(NSTimeZone *)zone;
+ (NSDate *)dateFrom:(NSString *)strDate withFormat:(NSString *)format;

+ (NSString *)getContactDay:(NSDate *)date;
+ (NSString *)getContactDayFormatMonthDay:(NSDate *)date;
+ (NSString *)getContactTime:(NSDate *)date;

/*
 *是否打开定位功能
 */
+ (BOOL)isLocationServiceEnabled;

/*
 *获取非Nil字符串
 */
+ (NSString *) getNonNullString:(NSString *)string;

/*
 *网络加载
 */
+ (void)showLoadingView;
+ (void)dismissLoadingView;

/*
 *是否包含Emoji表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
