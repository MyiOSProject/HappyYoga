//
//  HYGlobalParams.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYGlobalParams.h"
static HYGlobalParams *single;

@implementation HYGlobalParams
+ (HYGlobalParams *)sharedInstance{
    if (single == nil) {
        single = [[super allocWithZone:nil] init];
        single.anonymous = YES;
        single.firstUse = YES;
        single.loginToken = nil;
    }
    
    return  single;
}
+ (id)alloc
{
    return nil;
}

+ (id)new
{
    return [self alloc];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self alloc];
}

+ (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (id)mutableCopyWithZone:(NSZone *)zone
{
    return [self copyWithZone:zone];
}
@end
