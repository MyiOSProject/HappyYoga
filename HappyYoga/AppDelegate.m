//
//  AppDelegate.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "AppDelegate.h"
#import "HYGlobal.h"
#import "HYGlobalParams.h"
#import "HYUtility.h"
#import "HYMainTabBarViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIStoryboard *mainSB;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //定制导航条
    UIImage *bgImage = [UIImage imageNamed:@"navbar_bg.png"];
    UIImage *stretchedImage = [bgImage stretchableImageWithLeftCapWidth:1 topCapHeight:5];
    [[UINavigationBar appearance] setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *textAttr = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttr];
    
    //定制tabbar
    [[UITabBar appearance] setTintColor:YKT_SYS_APP_BLUE];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:YKT_SYS_APP_BLUE,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    HYGlobalParams *gParams = [HYGlobalParams sharedInstance];
    NSString *firstUse = [HYUtility loadCacheData:YKT_APP_FIRST_USED];
    if (!firstUse) {
        gParams.firstUse =  YES;
        [HYUtility saveCacheData:@"firstUsed" withKey:YKT_APP_FIRST_USED];
    }else{
        gParams.firstUse =  NO;
    }
    gParams.firstUse =  YES;
    gParams.anonymous = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:HY_NOTIFICATION_USER_SIGNOUT object:nil];
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *start = [mainSB instantiateViewControllerWithIdentifier:@"Main"];
    self.window.rootViewController = start;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:HY_NOTIFICATION_WIZARD_DISMISSED object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:HY_NOTIFICATION_LOGIN_DISMISSED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HY_NOTIFICATION_USER_SIGNOUT object:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:HY_NOTIFICATION_USER_SIGNOUT object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
}


#pragma mark -
#pragma mark notification handler
- (void)showLogin:(id)sender
{
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *start = [mainSB instantiateViewControllerWithIdentifier:@"Main"];
    self.window.rootViewController = start;
    [self.window makeKeyAndVisible];
}

@end
