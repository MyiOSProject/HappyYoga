//
//  HYMessageDBManager.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYMessageDBManager.h"

@implementation HYMessageDBManager

- (NSArray *)getMessageGrp:(NSString *)mobile {
    NSManagedObjectContext *manageContext = [HYDataUtil sharedInstance].managedObjectContext;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageModel" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@" mobile == %@", mobile];
    [request setPredicate:pre];
    
    NSArray *mos = [manageContext executeFetchRequest:request error:&error];
    NSCAssert(error == nil, error.description);
    return mos;
}

- (BOOL)clearMessageGrp:(NSString *)mobile {
    NSManagedObjectContext *manageContext = [HYDataUtil sharedInstance].managedObjectContext;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageModel" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@" mobile == %@", mobile];
    [request setPredicate:pre];
    
    NSArray *mos = [manageContext executeFetchRequest:request error:&error];
    NSCAssert(error == nil, error.description);
    if (mos && mos.count > 0) {
        for (id mo in mos) {
            [manageContext deleteObject:mo];
        }
    }
    BOOL result = [manageContext save:&error];
    NSAssert(result, error.description);
    return result;
    
}

- (BOOL)clearAllMessageGrp {
    NSManagedObjectContext *manageContext = [HYDataUtil sharedInstance].managedObjectContext;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageModel" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    
    NSArray *mos = [manageContext executeFetchRequest:request error:&error];
    NSCAssert(error == nil, error.description);
    if (mos && mos.count > 0) {
        for (id mo in mos) {
            [manageContext deleteObject:mo];
        }
    }
    BOOL result = [manageContext save:&error];
    NSAssert(result, error.description);
    return result;
    
}

- (BOOL)saveMessageGrp:(NSDictionary *)msgGrp {
    NSManagedObjectContext *manageContext = [HYDataUtil sharedInstance].managedObjectContext;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageModel" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    
    NSInteger mid = [[msgGrp objectForKey:@"mid"] integerValue];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@" mid == %d", mid];
    [request setPredicate:pre];
    
    HYMessageModel *mg = nil;
    NSArray *mos = [manageContext executeFetchRequest:request error:&error];
    NSCAssert(error == nil, error.description);
    if (mos.count == 0) {
        mg = [NSEntityDescription insertNewObjectForEntityForName:@"MessageModel" inManagedObjectContext:manageContext];
        mg.mid = mid;
        mg.customerName = [msgGrp objectForKey:@"customerName"];
        mg.content = [msgGrp objectForKey:@"content"];
        mg.createTime = [msgGrp objectForKey:@"createTime"];
        mg.customerId = [[msgGrp objectForKey:@"customerId"] integerValue];
        mg.unread = [[msgGrp objectForKey:@"unread"] boolValue];
        mg.mobile = [msgGrp objectForKey:@"mobile"];
    }
    BOOL result = [manageContext save:&error];
    NSAssert(result, error.description);
    return result;
}

- (BOOL)saveMessageGroup:(NSArray *)array {
    NSManagedObjectContext *manageContext = [HYDataUtil sharedInstance].managedObjectContext;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageModel" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    for (NSDictionary *msgGrp in array) {
        NSInteger mid = [[msgGrp objectForKey:@"mid"] integerValue];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@" mid == %d", mid];
        [request setPredicate:pre];
        HYMessageModel *mg = nil;
        NSArray *mos = [manageContext executeFetchRequest:request error:&error];
        NSCAssert(error == nil, error.description);
        if (mos.count == 0) {
            mg = [NSEntityDescription insertNewObjectForEntityForName:@"MessageModel" inManagedObjectContext:manageContext];
            mg.mid = mid;
            mg.customerName = [msgGrp objectForKey:@"customerName"];
            mg.content = [msgGrp objectForKey:@"content"];
            mg.createTime = [msgGrp objectForKey:@"createTime"];
            mg.customerId = [[msgGrp objectForKey:@"customerId"] integerValue];
            mg.unread = [[msgGrp objectForKey:@"unread"] boolValue];
            mg.mobile = [msgGrp objectForKey:@"mobile"];
        }
    }
    BOOL result = [manageContext save:&error];
    NSAssert(result, error.description);
    return result;
}

@end
