//
//  MemuViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MemuViewController.h"
#import "AFNetworking.h"
#import "BigTabView.h"
#import "YYModel.h"
#import "MenuModel.h"
#import "SmallCollectView.h"
#import "Common.h"


@interface MemuViewController ()

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet BigTabView *BigTabView;
@property (nonatomic,strong)UIView *btnView;
@property (nonatomic,strong)SmallCollectView *collectView;

@end


@implementation MemuViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"食谱";

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    [self _createColloctionView];
    [self _createNavBtn];
    [self _loadData];       //加载数据
}

//加载数据
-(void)_loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"actor.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dic[@"data"];
    for (NSDictionary *diction in array) {
        MenuModel *model = [MenuModel yy_modelWithDictionary:diction];
        [self.dataArr addObject:model];
    }
    
    self.BigTabView.dataArr = _dataArr;
    self.collectView.dataArr = _dataArr;
    [_BigTabView reloadData];
    [_collectView reloadData];
}

-(void)_createColloctionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectView = [[SmallCollectView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight-64-49) collectionViewLayout:layout];
    [self.view addSubview:_collectView];
    _collectView.hidden = YES;

}

-(void)_createNavBtn{

    UIButton *turnBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    turnBtn1.tag = 101;
    [turnBtn1 setImage:[UIImage imageNamed:@"icon－缩略图~iphone"] forState:UIControlStateNormal];
    [turnBtn1 addTarget:self action:@selector(turnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_btnView addSubview:turnBtn1];
    UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc]initWithCustomView:_btnView];
    self.navigationItem.leftBarButtonItem = itemBtn;
}

-(void)turnBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;

    _BigTabView.hidden = !_BigTabView.hidden;
    _collectView.hidden = !_collectView.hidden;
    
    [UIView transitionWithView:_btnView duration:.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"icon－list~iphone"] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"icon－缩略图~iphone"] forState:UIControlStateNormal];
        }
    } completion:^(BOOL finished) {
        
    }];
    
    CATransition *animation = [[CATransition alloc]init];
    animation.duration = 0.5;
    animation.type = @"rippleEffect";
    [self.view.layer addAnimation:animation forKey:@"animation1"];

}

@end
