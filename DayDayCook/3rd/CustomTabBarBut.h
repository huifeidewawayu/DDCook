//
//  CustomTabBarBut.h
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarBut : UIButton

@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,strong)NSString *textLab;
@property(nonatomic,strong)UIColor *textColor;
-(instancetype)initWithFrame:(CGRect)frame;
@end
