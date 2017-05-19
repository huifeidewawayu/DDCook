//
//  WebViewController.h
//  DayDayCook
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic,strong) NSString *webID;
@property (nonatomic,strong) NSString *detailsUrl;

-(void)setImgUrl:(NSString *)imgUrl withTitle:(NSString *)title;

@end
