//
//  HeadWebView.m
//  DayDayCook
//
//  Created by wurui on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HeadWebView.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "UIView+LoadView.h"

@interface HeadWebView () <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *clickLabel;
@property (nonatomic, strong) UIView *loadingView;
@end

@implementation HeadWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.loadingView];
//    给webView添加一个头视图
    CGRect headViewFrame = CGRectMake(0, 0, kScreenwidth, kScreenheight * 0.65);
    self.headView.frame = headViewFrame;
    [self.webView addSubview:self.headView];
    UIView *webBrowserView = self.webView.scrollView.subviews[0];
    CGRect frame = webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(headViewFrame);
    webBrowserView.frame = frame;
    [self.webView sendSubviewToBack:self.headView];
//    使头视图添加到scrollView上，使得一起滑动
    [self.webView.scrollView addSubview:self.headView];
    
    CGRect headImageFrame = CGRectMake(0, 0, kScreenwidth, CGRectGetHeight(headViewFrame) * 0.75);
    self.headImage.frame = headImageFrame;
    [self.headView addSubview:self.headImage];
    CGRect titleLabelFrame = CGRectMake(20 * kMDFScale, CGRectGetMaxY(headImageFrame) + 5, kScreenwidth - 40 * kMDFScale, CGRectGetHeight(headViewFrame) * 0.1);
    self.titleLabel.frame = titleLabelFrame;
    [self.headView addSubview:self.titleLabel];
    UIImageView *clickImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabelFrame), CGRectGetMaxY(titleLabelFrame) + 5, 20 * kMDFScale, 13 * kMDFScale)];
    clickImage.image = [UIImage imageNamed:@"live_history_click~iphone.png"];
    [self.headView addSubview:clickImage];
    CGRect clickLabelFrame = CGRectMake(CGRectGetMaxX(clickImage.frame) + 10, CGRectGetMinY(clickImage.frame), 150 * kMDFScale, CGRectGetHeight(clickImage.frame));
    self.clickLabel.frame = clickLabelFrame;
    [self.headView addSubview:self.clickLabel];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"back_icon~iphone"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
}

- (void)backAction {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25];
    [animation setType:kCATransitionMoveIn];
    [[[[UIApplication sharedApplication] keyWindow] layer] addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark  --- getter&setter
- (void)setModel:(SliderModel *)model {
    _model = model;
    NSURL *headImageUrl = (NSURL *)_model.imageUrl;
    [self.headImage sd_setImageWithURL:headImageUrl];
    self.titleLabel.text = _model.title;
    self.clickLabel.text = _model.clickCount;
    NSURL *url = [NSURL URLWithString:_model.url];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requset];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight)];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
    }
    return _headView;
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
    }
    return _headImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17 * kMDFScale];
    }
    return _titleLabel;
}

- (UILabel *)clickLabel {
    if (!_clickLabel) {
        _clickLabel = [[UILabel alloc] init];
        _clickLabel.font = [UIFont systemFontOfSize:13 * kMDFScale];
        _clickLabel.textColor = [UIColor grayColor];
    }
    return _clickLabel;
}

- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight)];
        _loadingView.backgroundColor = [UIColor clearColor];
    }
    return _loadingView;
}

#pragma mark  ---UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.loadingView beginLoading];
    return YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.loadingView.hidden = YES;
    [self.loadingView endLoading];
}

@end
