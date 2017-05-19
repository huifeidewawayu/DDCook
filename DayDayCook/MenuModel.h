//
//  MenuModel.h
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic,strong)NSString *imageUrl;     //图片
@property (nonatomic,strong)NSString *title;        //标题
@property (nonatomic,strong)NSString *introduce;    //介绍
@property (nonatomic,strong)NSString *maketime;     //发布时间
@property (nonatomic,strong)NSString *clickCount;   //点击的次数
@property (nonatomic,strong)NSString *shareCount;   //分享次数
@property (nonatomic,strong)NSString *releaseDate;  //时间
@property (nonatomic,strong)NSString *webID;         //id
@property (nonatomic,strong)NSString *detailsUrl;   //视频url

@end
