//
//  LoginViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
#import "RegistViewController.h"


@implementation LoginViewController



-(void)awakeFromNib{
    [self loadSubViews];
}


-(void)loadSubViews{
    
    UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 200, 25, 25)];
    userImgView.image = [UIImage imageNamed:@"accountImg~iphone"];
    [self.view addSubview:userImgView];

    UITextField *textFile1 = [[UITextField alloc]initWithFrame:CGRectMake(60, 200, kScreenwidth-90, 30)];
    textFile1.placeholder = @"输入手机号";
    [self.view addSubview:textFile1];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 240, kScreenwidth-60, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    
    UIImageView *passImgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 250, 25, 25)];
    passImgView.image = [UIImage imageNamed:@"passwordImg~iphone"];
    [self.view addSubview:passImgView];
    
    UITextField *textFile2 = [[UITextField alloc]initWithFrame:CGRectMake(60, 250, kScreenwidth-90, 30)];
    textFile2.placeholder = @"密码";
    [self.view addSubview:textFile2];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 290, kScreenwidth-60, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 310, kScreenwidth-60, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor  = [UIColor orangeColor];
    [loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 370, 50, 20)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    UIButton *rememBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenwidth-110, 370, 80, 20)];
    [rememBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [rememBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:rememBtn];
    
}

-(void)loginBtnAction:(UIButton *)btn{

}


-(void)registAction:(UIButton *)btn{
    RegistViewController *registVC = [[UIStoryboard storyboardWithName:@"MyselfStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"regist_ID"];
    
    [self presentViewController:registVC animated:YES completion:nil];
    
}

- (IBAction)returnBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)weiBtn:(UIButton *)sender {
}

- (IBAction)blogBtn:(UIButton *)sender {
}

- (IBAction)qqBtn:(UIButton *)sender {
}

- (IBAction)faceBtn:(UIButton *)sender {
}
@end
