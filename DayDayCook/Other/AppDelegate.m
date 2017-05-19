//
//  AppDelegate.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "VedioViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSString *dicPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/first.plist"];
    NSDictionary *firstDic = [[NSDictionary alloc]initWithContentsOfFile:dicPath];
    NSNumber *num = firstDic[@"first"];
    if (num == nil) {
        VedioViewController *vedioVC = [[VedioViewController alloc]init];
        self.window.rootViewController = vedioVC;
        NSDictionary *dic = @{@"first":@YES};
        [dic writeToFile:dicPath atomically:NO];
    }else{
        BaseViewController *baseVC = [[BaseViewController alloc]init];
        self.window.rootViewController = baseVC;
    }
    return YES;
}

@end
