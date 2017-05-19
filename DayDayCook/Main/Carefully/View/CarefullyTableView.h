//
//  CarefullyTableView.h
//  DayDayCook
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderModel.h"

@interface CarefullyTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *sliderArr;
@property(nonatomic,strong)NSMutableArray *foodMutArr;
@property(nonatomic,strong)NSMutableArray *themeMutArr;
@property(nonatomic,strong)SliderModel *model;
@end
