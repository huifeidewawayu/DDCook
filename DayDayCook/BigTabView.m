//
//  BigTabView.m
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BigTabView.h"
#import "BigMemuCell.h"
#import "Common.h"
#import "WebViewController.h"
#import "MemuViewController.h"
#import "MenuModel.h"

@interface BigTabView () <UITableViewDataSource,UITableViewDelegate>

@end


@implementation BigTabView

-(void)awakeFromNib{
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BigMemuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Memu_ID" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenwidth;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            MemuViewController *memuVC = (MemuViewController *)nextResponder;
            UIStoryboard *storyBd = [UIStoryboard storyboardWithName:@"MemuStoryboard" bundle:nil];
            WebViewController *webVC = [storyBd instantiateViewControllerWithIdentifier:@"web_ID"];

            webVC.hidesBottomBarWhenPushed = YES;
            
            CATransition *animation = [[CATransition alloc]init];
            animation.duration = .5;
            animation.type = @"fade";
            [self.window.layer addAnimation:animation forKey:@"animation2"];
            
            MenuModel *model = _dataArr[indexPath.row];
            webVC.webID = model.webID;
            webVC.detailsUrl = model.detailsUrl;
            [webVC setImgUrl:model.imageUrl withTitle:model.title];
            [memuVC presentViewController:webVC animated:YES completion:nil];
            break;
        }
    }
}

@end
