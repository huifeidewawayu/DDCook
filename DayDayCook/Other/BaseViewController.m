//
//  BaseViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "Common.h"
#import "CustomTabBarBut.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSMutableArray *tabBarButArr;
@property (nonatomic, strong) NSArray *selectImageArr;
@property (nonatomic, strong) NSArray *imageArr;

@end


@implementation BaseViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatContro];
    [self deleteSystemBut];
    [self creatCustomBut];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButton) name:@"showMenuView" object:nil];
    self.tabBar.translucent = NO;
}

-(void)creatContro{
//    把4个故事版作存放到数组中
    NSArray *storyBdArr = @[@"CarefullyStoryboard",@"MemuStoryboard",@"DiscoverStoryboard",@"MyselfStoryboard"];
    NSMutableArray *naviContro = [NSMutableArray array];
//    利用for循环将每一个故事版作为一个控制器，并添加到标签栏中
    for (NSInteger i = 0; i<storyBdArr.count; i++) {
        UIStoryboard *storyBd = [UIStoryboard storyboardWithName:storyBdArr[i] bundle:nil];
        UIViewController *storyContro = [storyBd instantiateInitialViewController];
        [naviContro addObject:storyContro];
    }
    self.viewControllers = naviContro;
}

-(void)deleteSystemBut{
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

-(void)creatCustomBut{
    NSArray *imageArr = @[@"tab_icon_choose_normal~iphone.png",@"tab_icon_recipe_normal~iphone.png",@"tab_icon_discover_normal~iphone.png",@"tab_icon_mine_normal~iphone.png"];
    NSArray *lableArr = @[@"精选",@"食谱",@"发现",@"我的"];
    self.tabBarButArr = [NSMutableArray array];
    for (NSInteger i =0; i<4; i++) {
        CustomTabBarBut *tabBut = [[CustomTabBarBut alloc]initWithFrame:CGRectMake(i*kScreenwidth/4, 0, kScreenwidth/4, kTabBarHeight)];
        tabBut.imageName = imageArr[i];
        tabBut.textLab = lableArr[i];
        tabBut.tag = 100 + i;
        [tabBut addTarget:self action:@selector(changeContro:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarButArr addObject:tabBut];
        [self.tabBar addSubview:tabBut];
    }
    CustomTabBarBut *firstBut = self.tabBarButArr[0];
    firstBut.textColor = [UIColor orangeColor];
    firstBut.imageName = @"tab_icon_choose_selected~iphone.png";
}

-(void)changeContro:(CustomTabBarBut *)btn{
    NSInteger select = btn.tag - 100;
    self.selectedIndex = select;
    
      self.imageArr = @[@"tab_icon_choose_normal~iphone.png",@"tab_icon_recipe_normal~iphone.png",@"tab_icon_discover_normal~iphone.png",@"tab_icon_mine_normal~iphone.png"];
    
     self.selectImageArr = @[@"tab_icon_choose_selected~iphone.png",@"tab_icon_recipe_selected~iphone.png",@"tab_icon_discover_selected~iphone.png",@"tab_icon_mine_selected~iphone.png"];
    
    for (NSInteger i = 0; i<self.tabBarButArr.count; i++) {
        CustomTabBarBut *tabBut = self.tabBarButArr[i];
        tabBut.imageName = self.imageArr[i];
        tabBut.textColor = [UIColor blackColor];
        if (tabBut.tag == btn.tag) {
            tabBut.textColor = [UIColor orangeColor];
            tabBut.imageName = self.selectImageArr[select];
        }
    }
}

- (void)changeButton {
    for (NSInteger i = 0; i<self.tabBarButArr.count; i++) {
        CustomTabBarBut *tabBut = self.tabBarButArr[i];
        if (i == 1) {
            tabBut.textColor = [UIColor orangeColor];
            tabBut.imageName = self.selectImageArr[i];
        } else {
            tabBut.imageName = self.imageArr[i];
            tabBut.textColor = [UIColor blackColor];
        }
    }
}

@end
