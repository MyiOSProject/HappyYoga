//
//  HYMessageModel.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface HYMessageModel : NSManagedObject
@property (nonatomic, strong, nonnull) NSString *customerName;
@property (nonatomic, strong, nullable) NSString *content;
@property (nonatomic, strong, nonnull) NSString *createTime;
@property (nonatomic) BOOL unread;
@property (nonatomic, strong, nonnull) NSString *mobile;
@property (nonatomic) int64_t mid;
@property (nonatomic) int64_t customerId;
@end
