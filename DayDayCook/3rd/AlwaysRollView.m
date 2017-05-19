//
//  AlwaysRollView.m
//  AlwaysRoll
//
//  Created by wurui on 17/3/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AlwaysRollView.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

static CGFloat const pageViewHeight = 30.f;
@interface AlwaysRollView () <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *alwaysRoll;
@property (nonatomic, strong)UIPageControl *pageView;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation AlwaysRollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.alwaysRoll];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
    return self;
}

//定时器方法
- (void)timingRoll:(NSTimer *)timer {
    //使当前所在的位置加1
    NSInteger value = self.alwaysRoll.contentOffset.x / kScreenwidth + 1;
    //偏移到下一张图片
    [self.alwaysRoll setContentOffset:CGPointMake(value * kScreenwidth, 0) animated:YES];
    self.pageView.currentPage = [self pageValue] + 1;
    if (self.alwaysRoll.contentOffset.x == self.alwaysRoll.contentSize.width - 2 * kScreenwidth) {
        self.alwaysRoll.contentOffset = CGPointMake(0, 0);
        self.pageView.currentPage = 0;
    }
}

#pragma mark  --- get && set
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.alwaysRoll.contentSize = CGSizeMake(_imageArray.count * kScreenwidth, self.frame.size.height);
    for (int i = 0; i<_imageArray.count; i++) {
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenwidth, 0, kScreenwidth, self.frame.size.height)];
        showImageView.contentMode = UIViewContentModeScaleAspectFit;
        [showImageView sd_setImageWithURL:_imageArray[i]];
        [self.alwaysRoll addSubview:showImageView];
    }
    self.pageView.numberOfPages = _imageArray.count - 2;
}

- (void)setIsPageView:(BOOL)isPageView {
    _isPageView = isPageView;
    if (isPageView) {
        [self addSubview:self.pageView];
    }
}

- (UIScrollView *)alwaysRoll {
    if (!_alwaysRoll) {
        _alwaysRoll = [[UIScrollView alloc] init];
        _alwaysRoll.frame = CGRectMake(0, 0, kScreenwidth, self.frame.size.height);
        _alwaysRoll.bounces = NO;
        _alwaysRoll.showsHorizontalScrollIndicator = NO;
        _alwaysRoll.contentOffset = CGPointMake(kScreenwidth, 0);
        _alwaysRoll.pagingEnabled = YES;
        _alwaysRoll.delegate = self;
        [self addSubview:_alwaysRoll];
    }
    return _alwaysRoll;
}

- (UIPageControl *)pageView {
    if (!_pageView) {
        _pageView = [[UIPageControl alloc] init];
        _pageView.frame = CGRectMake(0, self.frame.size.height - pageViewHeight * kMDFScale, self.frame.size.width, pageViewHeight * kMDFScale);
        _pageView.currentPage = 0;
    }
    return _pageView;
}

#pragma mark  --- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageView.currentPage = [self pageValue];
    //判断是否偏移到了最后一张图
    if (self.alwaysRoll.contentOffset.x == self.alwaysRoll.contentSize.width - kScreenwidth) {
        self.alwaysRoll.contentOffset = CGPointMake(kScreenwidth, 0);
        self.pageView.currentPage = [self pageValue];
    }else if (self.alwaysRoll.contentOffset.x == 0) {
        //滑动到倒数第二张图
        self.alwaysRoll.contentOffset = CGPointMake(self.alwaysRoll.contentSize.width -  2 * kScreenwidth, 0);
        self.pageView.currentPage = [self pageValue];
    }
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
    }
}

//计算滑动第几页
- (NSInteger)pageValue {
    return self.alwaysRoll.contentOffset.x / kScreenwidth - 1;
}

@end
