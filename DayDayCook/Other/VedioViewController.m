//
//  VedioViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VedioViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"

@interface VedioViewController ()
{
    AVPlayerViewController *_playVC;
}
@end

@implementation VedioViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _playVC = [[AVPlayerViewController alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"loadingVideo" ofType:@"mp4"];
    _playVC.player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    _playVC.showsPlaybackControls = NO;
    _playVC.view.frame = self.view.bounds;
    [self.view addSubview:_playVC.view];
    
    [_playVC.player play];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}



-(void)playerItemDidReachEnd:(NSNotification *)notify{
    BaseViewController *base = [[BaseViewController alloc]init];
    [UIView animateWithDuration:.25 animations:^{
        self.view.window.rootViewController = base;
    }];
    
}





@end
