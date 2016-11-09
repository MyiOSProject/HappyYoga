//
//  MainTabBarViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYMainTabBarViewController.h"

@interface HYMainTabBarViewController ()

@end

@implementation HYMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIStoryboard *sbCall = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    UIStoryboard *sbMessage = [UIStoryboard storyboardWithName:@"message" bundle:nil];
    UIStoryboard *sbMain = [UIStoryboard storyboardWithName:@"main" bundle:nil];
    UIStoryboard *sbMessage = [UIStoryboard storyboardWithName:@"message" bundle:nil];
    UIStoryboard *sbWork = [UIStoryboard storyboardWithName:@"work" bundle:nil];
    UIStoryboard *sbMy = [UIStoryboard storyboardWithName:@"me" bundle:nil];
    
    UINavigationController *navMain = [sbMain instantiateViewControllerWithIdentifier:@"hymain"];
    UIViewController *vcMain = navMain.topViewController;
    vcMain.title = @"main";
    vcMain.tabBarItem.title = @"main";
    vcMain.tabBarItem.image = [UIImage imageNamed:@"call_unsel@2x.png"];
    vcMain.tabBarItem.selectedImage = [UIImage imageNamed:@"call_sel@2x.png"];
    
    UINavigationController *navMessage = [sbMessage instantiateViewControllerWithIdentifier:@"hymessage"];
    UIViewController *vcMessage = navMessage.topViewController;
    vcMessage.title = @"message";
    vcMessage.tabBarItem.title = @"短信";
    vcMessage.tabBarItem.image = [UIImage imageNamed:@"message_unsel@2x.png"];
    vcMessage.tabBarItem.selectedImage = [UIImage imageNamed:@"message_sel@2x.png"];

    UINavigationController *navWork = [sbWork instantiateViewControllerWithIdentifier:@"hywork"];
    UIViewController *vcWork = navWork.topViewController;
    vcWork.title = @"work";
    vcWork.tabBarItem.title = @"工作";
    vcWork.tabBarItem.image = [UIImage imageNamed:@"work_unsel@2x.png"];
    vcWork.tabBarItem.selectedImage = [UIImage imageNamed:@"work_sel@2x.png"];

    
    UINavigationController *navMyapp = [sbMy instantiateViewControllerWithIdentifier:@"hyme"];
    UIViewController *vcMyapp = navMyapp.topViewController;
    vcMyapp.title = @"me";
    vcMyapp.tabBarItem.title = @"我的";
    vcMyapp.tabBarItem.image = [UIImage imageNamed:@"my_unsel@2x.png"];
    vcMyapp.tabBarItem.selectedImage = [UIImage imageNamed:@"my_sel@2x.png"];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            navMain,
                            navMessage,
                            navWork,
                            navMyapp,
                            nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
