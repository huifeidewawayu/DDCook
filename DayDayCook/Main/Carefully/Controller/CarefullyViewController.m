//
//  CarefullyViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CarefullyViewController.h"
#import "Common.h"
#import "YYModel.h"
#import "AFNetworking.h"
#import "SliderModel.h"
#import "CarefullyTableView.h"
#import "CollectionModel.h"
#import "HeadAlwaysRollView.h"
#import "HeadWebView.h"
#import "SearchViewController.h"
#import "CollectionModel.h"
#import "DoFoodsController.h"

@interface CarefullyViewController ()

@property (weak, nonatomic) IBOutlet CarefullyTableView *carefullyTab;
@end

@implementation CarefullyViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatThemeLogo];
    [self creatRightBut];
    [self sendNetRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushContro:) name:@"tiaozhuan" object:nil];
}

//视图将要出现发送通知打开定时器
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openTimer" object:self];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//视图将要消失发送通知关闭定时器
- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeTimer" object:self];
}

-(void)creatThemeLogo{
    
    UIImageView *themeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth/3, kNaviHeight/3)];
    themeView.image = [UIImage imageNamed:@"navi_logo~iphone.png"];
    themeView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = themeView;
}

-(void)creatRightBut{
    
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(0, 0, kNaviHeight/3, kNaviHeight/3);
    rightBut.contentMode = UIViewContentModeScaleAspectFit;
    [rightBut setImage:[UIImage imageNamed:@"icon-search~iphone.png"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *naviBarLeftBut = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = naviBarLeftBut;
}

-(void)searchAction{
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)sendNetRequest{
//    请求表视图的头视图数据
    NSString *jsonFile = [[NSBundle mainBundle]pathForResource:@"HeadView.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
    NSDictionary *HeadViewDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *HeadViewArr = HeadViewDic[@"data"];
    NSMutableArray *sliderArr = [NSMutableArray array];
    for (NSDictionary *sliderModelDic in HeadViewArr) {
        SliderModel *model = [SliderModel yy_modelWithDictionary:sliderModelDic];
        [sliderArr addObject:model];
    }
    _carefullyTab.sliderArr = sliderArr;
    [_carefullyTab reloadData];
    
    AFHTTPSessionManager *foodsManager = [[AFHTTPSessionManager alloc]init];

    NSString *foodsUrl = @"http://api.daydaycook.com.cn/daydaycook/recommend/queryRecommendAll.do";
    [foodsManager POST:foodsUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *foodsMutArr = [NSMutableArray array];
        NSDictionary *recipeDic = responseObject[@"data"];
        NSArray *recipeArr = recipeDic[@"recipeList"];
        for (NSDictionary *collectionModelDic in recipeArr) {
            CollectionModel *collectionModel = [CollectionModel yy_modelWithDictionary:collectionModelDic];
            [foodsMutArr addObject:collectionModel];
        }
        _carefullyTab.foodMutArr = foodsMutArr;
        [_carefullyTab reloadData];
        NSMutableArray *themeMutArr = [NSMutableArray array];
        NSDictionary *themeDic = responseObject[@"data"];
        NSArray *themeArr = themeDic[@"themeList"];
        for (NSDictionary *themeDic in themeArr) {
            CollectionModel *themeModel = [CollectionModel yy_modelWithDictionary:themeDic];
            [themeMutArr addObject:themeModel];
        }
        _carefullyTab.themeMutArr = themeMutArr;
        [_carefullyTab reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)pushContro:(NSNotification *)notification{
    CollectionModel *model = [notification object];
    DoFoodsController *doFood = [[DoFoodsController alloc] init];
    doFood.model = model;
    [self.navigationController pushViewController:doFood animated:YES];
}

@end
