//
//  HYLoginViewController.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGlobal.h"

@protocol HYLoginDelegate <NSObject>

@required
- (void)didLogin:(BOOL)success;

@end



@interface HYLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property(nonatomic,strong) id <HYLoginDelegate> delegate;

@end
