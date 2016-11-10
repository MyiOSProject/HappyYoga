//
//  HYPullingTableViewModel.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

typedef enum {
    kPTStateNormal=0,
    kPTStatePullingUp,
    kPTStatePullingDown,
    kPTStateRefreshing,
    kPTStateLoading
}PullingTableState;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol YKTPullingTableViewDelegate <NSObject>

@optional
- (void)pullingTableViewDidStartRefreshing;
- (void)pullingTableViewDidStartLoading;

@end

@interface HYPullingTableViewModel :NSObject
{
    PullingTableState _state;
}

@property (nonatomic) BOOL isRefreshing;

@property (nonatomic) BOOL isLoading;

@property (nonatomic) BOOL topEnd;

@property (nonatomic) BOOL bottomEnd;

@property (nonatomic, retain) id <YKTPullingTableViewDelegate> delegate;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

@end
