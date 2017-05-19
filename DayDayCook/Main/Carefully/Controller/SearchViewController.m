//
//  SearchViewController.m
//  DayDayCook
//
//  Created by wurui on 17/4/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SearchViewController.h"
#import "Common.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textFL;

@end

@implementation SearchViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.superview.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self setupSubViews];
    [self searchBar];
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
}

- (void)searchBar {
    UIImageView *leftBut = [[UIImageView alloc] init];
    leftBut.frame = CGRectMake(0, 0, 17 * kMDFScale, 17 * kMDFScale);
    leftBut.image = [UIImage imageNamed:@"search icon~iphone"];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
    barBtn.title=@"";
    self.navigationItem.leftBarButtonItem=barBtn;
    UITextField *searchText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 275 * kMDFScale, 30)];
    searchText.placeholder = @"食材/菜谱/主题";
    searchText.font = [UIFont systemFontOfSize:17 * kMDFScale];
    searchText.delegate = self;
    self.textFL = searchText;
    self.navigationItem.titleView = searchText;
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(0, 0, 40 * kMDFScale, 17 * kMDFScale);
    [rightBut setTitle:@"取消" forState:UIControlStateNormal];
    [rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    rightBut.titleLabel.font = [UIFont systemFontOfSize:17 * kMDFScale];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
}

- (void)backAction {
    [self.textFL resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)tapAction {
    [self.textFL resignFirstResponder];
}

#pragma mark  ---UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] init];
    NSArray *titleArr = @[@"煎饼",@"便当",@"烘焙",@"鸡肉"];
    for (int i = 0; i<4; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake((i * 65 + (i + 1) * 15) * kMDFScale, 10 * kMDFScale, 65 * kMDFScale, 30 * kMDFScale);
        [but setTitle:titleArr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:15 * kMDFScale];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.layer.borderWidth = 0.3;
        but.layer.cornerRadius = 3;
        [tableViewCell addSubview:but];
    }
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tableViewCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *headerView = [[UILabel alloc] init];
        CGFloat colorNum = 245/256.0;
        headerView.backgroundColor = [UIColor colorWithRed:colorNum green:colorNum blue:colorNum alpha:1];
        headerView.text = @"    热门搜索";
        headerView.font = [UIFont systemFontOfSize:14];
        self.tableView.tableHeaderView = headerView;
        return headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 35 * kMDFScale;
    } else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark  ---setter & getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_tableView addGestureRecognizer:tap];
    }
    return _tableView;
}

@end
