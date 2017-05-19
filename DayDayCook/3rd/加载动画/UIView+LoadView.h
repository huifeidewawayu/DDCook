//
//  UIView+LoadView.h
//  saa
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiLoadAnimationView.h"

@interface UIView (LoadView)

@property (strong, nonatomic) QiLoadAnimationView *loadingView;


- (void)beginLoading;


- (void)endLoading;


@end
