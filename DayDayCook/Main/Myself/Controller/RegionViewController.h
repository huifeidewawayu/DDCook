//
//  RegionViewController.h
//  DayDayCook
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlock)(NSString *a);

@interface RegionViewController : UIViewController
{
    MyBlock _myblock;
}

-(void)setMyblock:(MyBlock)block;


@end
