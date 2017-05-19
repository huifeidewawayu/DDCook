//
//  CustomTabBarBut.m
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CustomTabBarBut.h"

@interface CustomTabBarBut ()
{
    UIImageView *_imageView;
    UILabel *_labText;
}
@end

@implementation CustomTabBarBut

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:_imageName];
}

-(void)setTextLab:(NSString *)textLab{
    _textLab = textLab;
    _labText.text = _textLab;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _labText.textColor = _textColor;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-12, 8, 24, 24)];
        _imageView.image = [UIImage imageNamed:_imageName];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
        
        _labText = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-12, 31, 24, 21)];
        _labText.text = _textLab;
        _labText.font = [UIFont systemFontOfSize:11];
        _labText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labText];
    }
    return self;
}
@end
