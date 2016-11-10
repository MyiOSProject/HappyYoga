//
//  HYDataUtil.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYDataUtil.h"

@implementation HYDataUtil
+ (instancetype)sharedInstance {
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ketong.coreTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HappyYoga" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HappyYoga.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



/*ios10.0 code
 @synthesize persistentContainer = _persistentContainer;
 
 - (NSPersistentContainer *)persistentContainer {
 // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
 @synchronized (self) {
 if (_persistentContainer == nil) {
 _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ykt"];
 [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
 if (error != nil) {
 // Replace this implementation with code to handle the error appropriately.
 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 
 
 //                     Typical reasons for an error here include:
 //                     * The parent directory does not exist, cannot be created, or disallows writing.
 //                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
 //                     * The device is out of space.
 //                     * The store could not be migrated to the current model version.
 //                     Check the error message to determine what the actual problem was.
 
 NSLog(@"Unresolved error %@, %@", error, error.userInfo);
 abort();
 }
 }];
 }
 }
 
 return _persistentContainer;
 }
 
 #pragma mark - Core Data Saving support
 
 - (void)saveContext {
 NSManagedObjectContext *context = self.persistentContainer.viewContext;
 NSError *error = nil;
 if ([context hasChanges] && ![context save:&error]) {
 // Replace this implementation with code to handle the error appropriately.
 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 NSLog(@"Unresolved error %@, %@", error, error.userInfo);
 abort();
 }
 }
 */

#pragma mark - data access methods

- (void)insertObjectWithName:(NSString *)name dictonary:(NSDictionary *)dictionary {
    id managedObject = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
    [managedObject setValuesForKeysWithDictionary:dictionary];
    [self saveContext];
}

- (void)insertObjectWithName:(NSString *)name array:(NSArray *)array {
    
}

- (NSArray *)fetchObjectsWithName:(NSString *)name predicate:(NSPredicate *)predicate sortKeys:(NSArray *)sortkeys pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    if (sortkeys) {
        NSMutableArray *sortDescriptionKeys = [NSMutableArray array];
        for (NSDictionary *sort in sortkeys) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[sort objectForKey:@"key"] ascending: [[sort objectForKey:@"asc"] boolValue]];
            [sortDescriptionKeys addObject:sortDescriptor];
        }
        [fetchRequest setSortDescriptors:sortDescriptionKeys];
    }
    [fetchRequest setFetchOffset:pageIndex];
    [fetchRequest setFetchLimit:pageSize];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchedObjects;
}

- (NSArray *)fetchObjectsWithName:(NSString *)name predicate:(NSPredicate *)predicate sortKeys:(NSArray *)sortkeys {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    if (sortkeys) {
        NSMutableArray *sortDescriptionKeys = [NSMutableArray array];
        for (NSDictionary *sort in sortkeys) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[sort objectForKey:@"key"] ascending: [[sort objectForKey:@"asc"] boolValue]];
            [sortDescriptionKeys addObject:sortDescriptor];
        }
        [fetchRequest setSortDescriptors:sortDescriptionKeys];
    }
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchedObjects;
}

- (void)deleteAllObjects:(NSString *)name {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *data = [context executeFetchRequest:fetchRequest error:&error];
    if (!error && data && (data.count > 0)) {
        for (NSManagedObject *obj in data) {
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            NSLog(@"error:%@", error);
        }
    }
}

@end
