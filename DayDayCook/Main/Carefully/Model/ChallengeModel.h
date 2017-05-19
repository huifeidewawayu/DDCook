//
//  ChallengeModel.h
//  DayDayCook
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChallengeModel : NSObject

@property(nonatomic,strong)NSString *indexImgUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *levelInfo;
@property(nonatomic,assign)NSInteger participantCount;
@property(nonatomic,assign)NSInteger level;
@end
