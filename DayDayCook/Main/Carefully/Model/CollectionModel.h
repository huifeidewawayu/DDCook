//
//  CollectionModel.h
//  DayDayCook
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *descriptionDoing;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSString *click_count;
@property (nonatomic, strong) NSString *detailsUrl;

@end
