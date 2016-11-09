//
//  HYMeViewController.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMeViewController : UITableViewController
{
    NSMutableArray *_data;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;

- (IBAction)touchLogout:(id)sender;
@end
