//
//  HYGlobalParams.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYGlobalParams : NSObject
@property BOOL anonymous;

@property BOOL firstUse;

@property (copy, nonatomic) NSString *mobile;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *loginToken;

@property (copy, nonatomic) NSString *realMobile;

@property (copy, nonatomic) NSString *group;

@property (nonatomic) NSInteger groupId;


@property BOOL netConnected;

+ (HYGlobalParams *)sharedInstance;

@end
