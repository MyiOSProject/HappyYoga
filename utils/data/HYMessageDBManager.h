//
//  HYMessageDBManager.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYMessageModel.h"
#import "HYDataUtil.h"

@interface HYMessageDBManager : NSObject
- (NSArray *)getMessageGrp:(NSString *)mobile;
- (BOOL)saveMessageGrp:(NSDictionary *)msgGrp;
- (BOOL)saveMessageGroup:(NSArray *)array;
- (BOOL)clearMessageGrp:(NSString *)mobile;
- (BOOL)clearAllMessageGrp;
@end
