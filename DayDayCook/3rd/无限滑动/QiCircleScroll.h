//
//  QiCircleScroll.h
//  123123
//
//  Created by ouyangqi on 16/10/25.
//  Copyright © 2016年 ouyangqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiCircleScroll : UIView


@property (nonatomic,strong)NSArray *imgArr;        //图片数组

@property (nonatomic,assign)NSInteger circleCount;  //循环周期


@end



//使用说明
/*
 
 1.创建对象，设置frame
 2.传入图片数组
 3.传入循环周期（时间）
 
 */