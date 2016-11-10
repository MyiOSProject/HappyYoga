//
//  HYPullingTableViewModel.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//
#define kPTMOffsetY 60.f

#import "HYPullingTableViewModel.h"

@implementation HYPullingTableViewModel
- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    if (!_isLoading) {
        _state = kPTStateNormal;
    }
}

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    if (!_isRefreshing) {
        _state = kPTStateNormal;
    }
}

- (void)setTopEnd:(BOOL)topEnd {
    _topEnd = topEnd;
    if (_topEnd) {
        _state = kPTStateNormal;
    }
    
}

- (void)setBottomEnd:(BOOL)bottomEnd {
    _bottomEnd = bottomEnd;
    if (_bottomEnd) {
        _state = kPTStateNormal;
    }
    
}

- (void)setAtTheEnd:(BOOL)atTheEnd {
    _bottomEnd = atTheEnd;
    if (_bottomEnd) {
        _state = kPTStateNormal;
    }
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {
    if (_state == kPTStateLoading || _state == kPTStateRefreshing) {
        return;
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
    
    float yMargin = offset.y + size.height - contentSize.height;
    if (offset.y < -kPTMOffsetY) {   //header totally appeard
        _state = kPTStatePullingDown;
    } else if (offset.y > -kPTMOffsetY && offset.y < 0){ //header part appeared
        _state = kPTStateNormal;
        
    } else if ( yMargin > kPTMOffsetY){  //footer totally appeared
        _state = kPTStatePullingUp;
    } else if ( yMargin < kPTMOffsetY && yMargin > 0) {//footer part appeared
        _state = kPTStateNormal;
    }
    
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView {
    if (_state == kPTStateLoading || _state == kPTStateRefreshing ) {
        return;
    }
    
    if (_state == kPTStatePullingDown) {
        if (_topEnd) {
            return;
        }
        _state = kPTStateRefreshing;
        if (_delegate && [_delegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing)]) {
            [_delegate pullingTableViewDidStartRefreshing];
        }
    } else if (_state == kPTStatePullingUp) {
        if (_bottomEnd) {
            return;
        }
        _state = kPTStateLoading;
        if (_delegate && [_delegate respondsToSelector:@selector(pullingTableViewDidStartLoading)]) {
            [_delegate pullingTableViewDidStartLoading];
        }
    }
}

@end
