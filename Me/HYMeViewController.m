//
//  HYMeViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYMeViewController.h"
#import "HYGlobal.h"
#import "HYUtility.h"
#import "HYGlobalParams.h"
#import "HYMeIndexCell.h"


@interface HYMeViewController ()
{
    BOOL _showWork;
}
@end

@implementation HYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    
    //label标签添加触摸手势
    [_mobileLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMobile:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_mobileLabel addGestureRecognizer:tap];
    
    
    _data = [[NSMutableArray alloc] initWithCapacity:4];
    //    NSDictionary *dic0 = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_notification.png",@"image", @"消息推送",  @"name", @"",@"suffix", nil];
    //    [_data addObject:dic0];
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_password.png",@"image", @"修改密码",  @"name", @"",@"suffix", nil];
    [_data addObject:dic1];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_ykt.png",@"image", @"关于",  @"name", @"",@"suffix", nil];
    [_data addObject:dic2];
    NSDictionary *dictAppInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [NSString stringWithFormat:@"Ver%@", [dictAppInfo objectForKey:@"CFBundleShortVersionString"]];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_version.png",@"image", @"版本更新",  @"name", version, @"suffix", nil];
    [_data addObject:dic3];
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_aboutus.png",@"image", @"联系我们",  @"name", @"10010",@"suffix", nil];
    [_data addObject:dic4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Navigation
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYMeIndexCell *cell = (HYMeIndexCell *)[tableView dequeueReusableCellWithIdentifier:@"MyIndexCell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *item = [_data objectAtIndex:indexPath.row];
    cell.settingIcon.image = [UIImage imageNamed:[item objectForKey:@"image"]];
    cell.settingName.text = [item objectForKey:@"name"];
    NSString *suffix = [HYUtility getNonNullString:[item objectForKey:@"suffix"]];
    if (suffix.length > 0) {
        cell.suffixLabel.text = [item objectForKey:@"suffix"];
    }else{
        cell.suffixLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            //        case 0://push notification
            //        {
            //
            //        }
            //            break;
        case 0://change pwd
        {
//            [self performSegueWithIdentifier:@"segChangePwd" sender:nil];
        }
            break;
        case 1://about ykt
        {
            UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
            [self.view addSubview:view] ;
        }
            break;
        case 2://version
        {
            
        }
            break;
        case 3://contact us
        {
            UIApplication *myApp = [UIApplication sharedApplication];
            [myApp openURL:[NSURL URLWithString:@"tel://10010"]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Navigation
- (void)tapMobile:(UITapGestureRecognizer *)gesture {
    _mobileLabel.text = _showWork ? @"点我啊！" : @"点我了";

    _showWork = !_showWork;
}

- (IBAction)touchLogout:(id)sender{
    HYGlobalParams *gParams = [HYGlobalParams sharedInstance];
    gParams.anonymous = YES;
    gParams.loginToken = nil;
    [HYUtility clearCacheData:HY_APP_LOGIN_USERNAME];
    [HYUtility clearCacheData:HY_APP_LOGIN_PWD];
    [[NSNotificationCenter defaultCenter] postNotificationName:HY_NOTIFICATION_USER_SIGNOUT object:nil];
}
@end
