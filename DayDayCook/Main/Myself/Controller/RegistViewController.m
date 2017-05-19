//
//  RegistViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

- (IBAction)backBTN:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *GainBtn;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSTimer *timer;

- (IBAction)GainBtn:(UIButton *)sender;
- (IBAction)OKBtn:(id)sender;


@end


@implementation RegistViewController
- (void)dealloc {
    [_timer invalidate];
}

-(void)viewDidLoad{
    [super viewDidLoad];

    _GainBtn.layer.borderWidth = 1;
    _GainBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _GainBtn.layer.cornerRadius = 10;
}





- (IBAction)backBTN:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)GainBtn:(UIButton *)sender {
    self.second = 30;
    [sender setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.second] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:10];
    [sender setTintColor:[UIColor grayColor]];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownAction:) userInfo:nil repeats:YES];
    sender.enabled = NO;
}

- (IBAction)OKBtn:(id)sender {
}

- (void)countdownAction:(NSTimer *)timer {
    self.second = self.second - 1;
    if (self.second <= 0) {
        self.GainBtn.enabled = YES;
        [_timer invalidate];
        _timer = nil;
        [self.GainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.GainBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.GainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        });
    } else {
        [self.GainBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.second] forState:UIControlStateNormal];
    }
}

@end
