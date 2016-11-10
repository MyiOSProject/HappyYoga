//
//  HYLoginViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYLoginViewController.h"
#import "HYGlobal.h"
#import "HYUtility.h"

@interface HYLoginViewController ()

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIButton *)sender {
    [HYUtility saveCacheData:@"sa" withKey:HY_APP_LOGIN_USERNAME];
    [HYUtility saveCacheData:@"123" withKey:HY_APP_LOGIN_PWD];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [_delegate didLogin:YES];
}
- (IBAction)register:(UIButton *)sender {
    [HYUtility clearCacheData:HY_APP_FIRST_USED];
    [HYUtility clearCacheData:HY_APP_LOGIN_USERNAME];
    [HYUtility clearCacheData:HY_APP_LOGIN_PWD];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
