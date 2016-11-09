//
//  HYWizardViewController.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGlobal.h"
#import "HYGlobalParams.h"
#import "HYUtility.h"
#import "UIView+Extension.h"

@protocol HYWizardDelegate <NSObject>

@required
- (void)wizardDidDismiss;
@end




@interface HYWizardViewController : UIViewController
@property(nonatomic,strong) id <HYWizardDelegate> delegate;
@end
