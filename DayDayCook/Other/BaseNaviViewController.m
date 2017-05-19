//
//  BaseNaviViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bar_bg~iphone.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:
            UIScreenEdgePanGestureRecognizer.class];
}

@end
