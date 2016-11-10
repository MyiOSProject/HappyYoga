//
//  LCAlertView.h
//  uni114
//
//  Created by wangyong on 13-2-14.
//
//

#import <UIKit/UIKit.h>

typedef void(^LCAlertBlock)(void);


@interface LCAlertView : UIAlertView

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(LCAlertBlock)cancelBlock
           otherTitle:(NSString *)otherTitle
           otherBlock:(LCAlertBlock)otherBlock;
@end
