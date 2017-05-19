//
//  UIView+LoadView.m
//  saa
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 xiami. All rights reserved.
//

#import "UIView+LoadView.h"
#import <objc/runtime.h>

static const void *LoadingView_Key = "loadingView_Key";

@implementation UIView (LoadView)


-(void)setLoadingView:(QiLoadAnimationView *)loadingView{
    
    objc_setAssociatedObject(self, &LoadingView_Key,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QiLoadAnimationView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingView_Key);
}

-(void)beginLoading{
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[QiLoadAnimationView alloc] initWithFrame:self.bounds];
        [self addSubview:self.loadingView];
        [self.loadingView startAnimation];
    }else{
        [self.loadingView startAnimation];
    }
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopLoadAnimation];
    }
}
@end

