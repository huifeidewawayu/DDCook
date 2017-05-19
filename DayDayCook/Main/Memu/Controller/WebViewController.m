//
//  WebViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WebViewController.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIView+LoadView.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    AVPlayerViewController *_playVC;
    UIView *_loadView;
}

@end


@implementation WebViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)awakeFromNib{
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.scrollView.contentInset = UIEdgeInsetsMake(kScreenwidth, 0, 49, 0);
    _webView.delegate = self;
    _webView.scrollView.backgroundColor = [UIColor colorWithRed:245/255.00 green:245/255.00 blue:245/255.00 alpha:1];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    //_loadView = [[UIView alloc]initWithFrame:CGRectMake(kScreenwidth/2-40, kScreenheight/2-40, 80, 80)];
    _loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight)];
    _loadView.backgroundColor = [UIColor clearColor];
    [_webView addSubview:_loadView];
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

//http://pic.daydaycook.com/production/videos/20161020/3e8ab017-cda6-41cc-aaf8-355e9fa36db1

//http://api.daydaycook.com.cn:80/daydaycook/h5/recipe/recipedetail.do?id=39306&languageId=3&mainland=1&ver=2.1.2&regionCode=156

//http://api.daydaycook.com.cn/daydaycook/h5/recipe/loadContent.do?id=39306&languageId=3&mainland=1&ver=2.1.2&regionCode=156

-(void)setWebID:(NSString *)webID{
    _webID = webID;
    NSString *urlStr = [NSString stringWithFormat:@"http://api.daydaycook.com.cn/daydaycook/h5/recipe/loadContent.do?id=%@&languageId=3&mainland=1&ver=2.1.2&regionCode=156",_webID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requset];
    [self addSubViews];
}

-(void)addSubViews{
    //添加返回按钮
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 30, 30)];
    [returnBtn setImage:[UIImage imageNamed:@"back_icon~iphone"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:returnBtn];
    //向上按钮
    UIButton * upBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenwidth-50, kScreenheight-100, 40, 40)];
    [upBtn setImage:[UIImage imageNamed:@"upupupIcon~iphone"] forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:upBtn];
    UILabel *barLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenheight-49, kScreenwidth, 49)];
    barLable.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    [_webView addSubview:barLable];
    NSArray *btnImg = @[@"Details_tabcommentIcon~iphone",@"Details_tabfavIcon~iphone",@"Details_font~iphone",@"Details_tabshare~iphone"];
    for (int i=0; i<4; i++) {
        UIButton *barBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenwidth/8-15)+kScreenwidth/4*i, kScreenheight-49+10, 30, 30)];
        [barBtn setImage:[UIImage imageNamed:btnImg[i]] forState:UIControlStateNormal];
        [barBtn addTarget:self action:@selector(barBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        barBtn.tag = 300+i;
        [_webView addSubview:barBtn];
    }
}

-(void)setImgUrl:(NSString *)imgUrl withTitle:(NSString *)title{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kScreenwidth, kScreenwidth, kScreenwidth-50)];
    imgView.userInteractionEnabled = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [_webView.scrollView addSubview:imgView];
    if (_detailsUrl) {
        UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        playBtn.center = imgView.center;
        [playBtn setImage:[UIImage imageNamed:@"play~iphone"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_webView.scrollView addSubview:playBtn];
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame)+10, kScreenwidth-20, 40)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_webView.scrollView addSubview:titleLabel];
}

-(void)playBtnAction:(UIButton *)btn{
    if (_detailsUrl) {
        _playVC = [[AVPlayerViewController alloc]init];
        _playVC.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:_detailsUrl]];
        [_playVC.player play];
        [self presentViewController:_playVC animated:YES completion:nil];
    }
}

-(void)barBtnAction:(UIButton *)btn{
    if (btn.tag == 300) {
        
    }
}

-(void)btnAction:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)upBtnAction:(UIButton *)btn{
    [_webView.scrollView setContentOffset:CGPointMake(0,-kScreenwidth) animated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [_loadView beginLoading];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _loadView.hidden = YES;
    [_loadView endLoading];
}

@end
