//
//  QiLoadAnimationView.h
//  saa
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiLoadAnimationView : UIView


- (instancetype)initWithFrame:(CGRect)frame;


//- (instancetype)initWithStartLoad;

@property (nonatomic,strong) UIImageView *loadImage;


-(void)startAnimation;


-(void)stopLoadAnimation;


@end
