//
//  HYApiResult.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYApiResult : NSObject
@property (nonatomic) NSInteger result;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id value;

@end
