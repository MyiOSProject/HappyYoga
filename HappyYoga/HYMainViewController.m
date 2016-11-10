//
//  HYMainViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYMainViewController.h"

@interface HYMainViewController ()

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [HYUtility clearCacheData:YKT_APP_FIRST_USED];
    [self juageWhereTo:[HYGlobalParams sharedInstance]];
}

- (void)juageWhereTo:(HYGlobalParams *)params{
    NSString *firstUse  = [HYUtility loadCacheData:HY_APP_FIRST_USED];
    NSLog(@"====firstUse:%@",firstUse);
    if (!firstUse) {
        params.firstUse = YES;
        [HYUtility saveCacheData:@"firstUse" withKey:HY_APP_FIRST_USED];
        
        [HYUtility clearCacheData:HY_APP_FIRST_USED];
    }else{
        params.firstUse = NO;
    }
//    NSString *str = params.firstUse;
//    [str isEqualToString:@"firstUse"];
    NSLog(@"====params.firstUse:%@===",params.firstUse?@"true":@"false");
    if (params.firstUse) {
        [self performSegueWithIdentifier:@"segShowWizard" sender:nil];
        return;
    }
    
    
    params.anonymous = YES;
    [self autoLogin];
}

- (void)autoLogin{
    NSString *mobile = [HYUtility loadCacheData:HY_APP_LOGIN_USERNAME];
    NSString *pwd = [HYUtility loadCacheData:HY_APP_LOGIN_PWD];
//    [self performSegueWithIdentifier:@"segShowLogin" sender:nil];
//    return;
    if (mobile && pwd) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        [params setValue:mobile forKey:@"workmobile"];
        [params setValue:pwd forKey:@"pwd"];
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *start = [mainSB instantiateViewControllerWithIdentifier:@"MainTabBar"];
        [UIApplication sharedApplication].keyWindow.rootViewController = start;
    }else{
        [self performSegueWithIdentifier:@"segShowLogin" sender:nil];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segShowLogin"]) {
        HYLoginViewController *login = (HYLoginViewController *)[segue destinationViewController];
        login.delegate = self;
    }else if ([segue.identifier isEqualToString:@"segShowWizard"]){
        HYWizardViewController *wizard = (HYWizardViewController *)[segue destinationViewController];
        wizard.delegate = self;
    }
}

- (void)didLogin:(BOOL)success{
    if (success) {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *start = [mainSB instantiateViewControllerWithIdentifier:@"MainTabBar"];
        [UIApplication sharedApplication].keyWindow.rootViewController = start;
        return;
    }
}

- (void)wizardDidDismiss {
    [self performSegueWithIdentifier:@"segShowLogin" sender:nil];
}

@end
