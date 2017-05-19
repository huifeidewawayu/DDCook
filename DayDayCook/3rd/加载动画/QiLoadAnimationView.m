//
//  QiLoadAnimationView.m
//  saa
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 xiami. All rights reserved.
//

#import "QiLoadAnimationView.h"
#import "UIView+LoadView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation QiLoadAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.loadImage.bounds = CGRectMake(0, 0, 80, 80);
        self.loadImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:self.loadImage];
        
        NSMutableArray *imageNSarray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<8; i++) {
            [imageNSarray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"scg_icon_windmill_%d~iphone",i]]];
        }
        //设置动画数组
        [self.loadImage setAnimationImages:imageNSarray];
        //设置动画播放次数
        [self.loadImage setAnimationRepeatCount:0];
        //设置动画播放时间
        [self.loadImage setAnimationDuration:1];
        
    }
    return self;
}

#pragma mark -- 开始动画
-(void)startAnimation{
    //开始动画
    [self.loadImage startAnimating];
}

-(void)stopLoadAnimation{
    
    [self removeFromSuperview];
    
}

-(UIImageView *)loadImage{
    
    if (!_loadImage) {
        _loadImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8"]];
    }
    return _loadImage;
    
}

@end
