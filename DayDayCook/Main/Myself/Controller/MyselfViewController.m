//
//  MyselfViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyselfViewController.h"
#import "LoginViewController.h"
#import "Common.h"

@interface MyselfViewController ()

@property (nonatomic, strong) UIImageView *lineImgView;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *wayBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *modelName;

- (IBAction)iconBtn:(id)sender;
- (IBAction)collectBtn:(UIButton *)sender;
- (IBAction)wayBtn:(UIButton *)sender;
- (IBAction)backBtn:(id)sender;

@end


@implementation MyselfViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationItem.rightBarButtonItem.customView setAlpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
    
}

- (void)configViews {
    _backBtn.layer.cornerRadius = 5;
    _backBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _backBtn.layer.borderWidth = 1;
    [_backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    self.lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 239, kScreenwidth/2, 1)];
    self.lineImgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.lineImgView];

}

- (IBAction)iconBtn:(id)sender {
    UIStoryboard *stbd = [UIStoryboard storyboardWithName:@"MyselfStoryboard" bundle:nil];
    LoginViewController *loginVC = [stbd instantiateViewControllerWithIdentifier:@"loginID"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)collectBtn:(UIButton *)sender {
    [UIView animateWithDuration:.25 animations:^{
        self.lineImgView.center = CGPointMake(sender.center.x, self.lineImgView.center.y);
    }];
    _modelName.text = @"看到喜欢的菜谱记得收藏喔";
}

- (IBAction)wayBtn:(UIButton *)sender {
    [UIView animateWithDuration:.25 animations:^{
        self.lineImgView.center = CGPointMake(sender.center.x, self.lineImgView.center.y);
    }];
    _modelName.text = @"您目前还没有浏览足迹";
}

- (IBAction)backBtn:(id)sender {
    self.tabBarController.selectedIndex = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMenuView" object:self];
}

@end
