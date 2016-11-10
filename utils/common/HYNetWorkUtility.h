//
//  HYNetWorkUtility.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYApiResult.h"

typedef void(^SuccessBlock)(HYApiResult *ret , NSURLResponse *response);
typedef void(^failBlock)(NSError *error);

@interface HYNetWorkUtility : NSObject

+ (instancetype)sharedInstance;

- (void)getRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail;
- (void)postRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail;
- (void)syncPostRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail;
@end
