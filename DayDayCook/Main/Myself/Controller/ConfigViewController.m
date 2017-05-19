//
//  ConfigViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ConfigViewController.h"
#import "SDImageCache.h"
#import "RegionViewController.h"

@interface ConfigViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UISwitch *choseBtn;
@property (weak, nonatomic) IBOutlet UILabel *rigionLabel;


- (IBAction)choseBtn:(UISwitch *)sender;


@end

@implementation ConfigViewController





-(void)awakeFromNib{
    self.tableView.delegate = self;
    //self.tableView.dataSource = self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"设置";
    
    _choseBtn.onImage = [UIImage imageNamed:@"accept_on_bg~iphone"];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self _caculateCache];
    
    NSString *regionName = [[NSUserDefaults standardUserDefaults] objectForKey:@"regions"];
    if (regionName) {
        _rigionLabel.text = regionName;
    }else{
        _rigionLabel.text = @"中国";
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 1){
        return 10;
    }
    return 50;
}


- (IBAction)choseBtn:(UISwitch *)sender {
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清空缓存?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
            [[SDImageCache sharedImageCache]clearMemory];
            [self _caculateCache];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertCtrl addAction:action1];
        [alertCtrl addAction:action2];
        [self.navigationController presentViewController:alertCtrl animated:YES completion:nil];
    }else if (indexPath.section == 1){
    
        if (indexPath.row ==1) {
            
            RegionViewController *regionVC = [[RegionViewController alloc]init];
            [regionVC setMyblock:^(NSString *a) {
                _rigionLabel.text = a;
                [[NSUserDefaults standardUserDefaults]setValue:a forKey:@"regions"];
            }];
            [self.navigationController pushViewController:regionVC animated:YES];
            
        }
    }
}

//计算缓存方法
-(void)_caculateCache{
    NSUInteger size = [[SDImageCache sharedImageCache]getSize];
    float cache = size/1024.0/1024;
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fM",cache];
}

@end
