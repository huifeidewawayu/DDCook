//
//  RegionViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RegionViewController.h"

@interface RegionViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)UITableView *tabView;

@end


@implementation RegionViewController


-(void)viewDidLoad{
    [super viewDidLoad];

    [self _loadData];
    
    [self createTabView];
}

-(void)_loadData{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"regions" ofType:@"plist"];
    _dataArr = [NSArray arrayWithContentsOfFile:path];
    
}

-(void)createTabView{
    _tabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tabView];
    
    _tabView.dataSource = self;
    _tabView.delegate = self;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell_ID";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArr[indexPath.row][@"2"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *text = _dataArr[indexPath.row][@"2"];
    _myblock(text);
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setMyblock:(MyBlock)block{
    _myblock = block;
}

@end
