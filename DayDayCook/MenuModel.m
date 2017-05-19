//
//  MenuModel.m
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"introduce" : @"description",
             @"webID" : @"id"
             };
}

@end
