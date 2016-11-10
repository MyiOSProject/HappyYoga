//
//  HYMessageListTableViewCell.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMessageListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (weak, nonatomic) IBOutlet UILabel *unread;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
