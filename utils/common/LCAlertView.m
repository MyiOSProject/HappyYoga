//
//  LCAlertView.m
//  uni114
//
//  Created by wangyong on 13-2-14.
//
//

#import "LCAlertView.h"

@interface LCAlertView ()

@property (nonatomic, copy) LCAlertBlock cancelBlock;
@property (nonatomic, copy) LCAlertBlock otherBlock;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *otherButtonTitle;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        cancelBlock:(LCAlertBlock)cancelBlock
         otherTitle:(NSString *)otherTitle
         otherBlock:(LCAlertBlock)otherBlock;
@end

@implementation LCAlertView

@synthesize cancelBlock;
@synthesize otherBlock;
@synthesize cancelButtonTitle;
@synthesize otherButtonTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle {
    [self showWithTitle:title message:message
            cancelTitle:buttonTitle cancelBlock:nil
             otherTitle:nil otherBlock:nil];
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(LCAlertBlock)cancelBlk
           otherTitle:(NSString *)otherTitle
           otherBlock:(LCAlertBlock)otherBlk {
    [[[self alloc] initWithTitle:title message:message
                      cancelTitle:cancelTitle cancelBlock:cancelBlk
                       otherTitle:otherTitle otherBlock:otherBlk]
      show];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        cancelBlock:(LCAlertBlock)cancelBlk
         otherTitle:(NSString *)otherTitle
         otherBlock:(LCAlertBlock)otherBlk {
    
    if ((self = [super initWithTitle:title
                             message:message
                            delegate:self
                   cancelButtonTitle:cancelTitle
                   otherButtonTitles:otherTitle, nil])) {
        
        if (cancelBlk == nil && otherBlk == nil) {
            self.delegate = nil;
        }
        self.cancelButtonTitle = cancelTitle;
        self.otherButtonTitle = otherTitle;
        self.cancelBlock = cancelBlk;
        self.otherBlock = otherBlk;
    }
    return self;
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:self.cancelButtonTitle]) {
        if (self.cancelBlock) self.cancelBlock();
    } else if ([buttonTitle isEqualToString:self.otherButtonTitle]) {
        if (self.otherBlock) self.otherBlock();
    }
}

- (void)dealloc {
    cancelButtonTitle = nil;
    otherButtonTitle = nil;
    cancelBlock = nil;
    otherBlock = nil;
}


@end
