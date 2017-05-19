//
//  LVMIndexRecommendAdvertisingCell.m
//  Secoo-iPhone
//
//  Created by wurui on 17/3/1.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "HeadAlwaysRollView.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "SliderModel.h"
#import "CarefullyViewController.h"
#import "HeadWebView.h"

static CGFloat const pageViewHeight = 30.f;
static NSString * const LVMIndexRecommendAdvertisingCollectionViewCellID = @"LVMIndexRecommendAdvertisingCollectionViewCellID";

@interface LVMIndexRecommendAdvertisingCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation LVMIndexRecommendAdvertisingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    CGRect imageViewFrame = CGRectMake(0, 0, kScreenwidth, self.frame.size.height);
    self.imageView.frame = imageViewFrame;
    [self addSubview:self.imageView];
}

- (void)setItem:(id)item {
    [self.imageView sd_setImageWithURL:item];
}

#pragma mark  --- getter & setter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end


@interface HeadAlwaysRollView ()
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageView;

@end


@implementation HeadAlwaysRollView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeFromSuperview
{
    [self stopBannerTimer];
    
    [super removeFromSuperview];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startBannerTimer) name:@"openTimer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopBannerTimer) name:@"closeTimer" object:nil];
    return self;
}

#pragma mark  --- get && set
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.collectionView.contentSize = CGSizeMake(_imageArray.count * kScreenwidth, self.frame.size.height);
    for (int i = 0; i<_imageArray.count; i++) {
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenwidth, 0, kScreenwidth, self.frame.size.height)];
        showImageView.contentMode = UIViewContentModeScaleAspectFit;
        [showImageView sd_setImageWithURL:_imageArray[i]];
        [self.collectionView addSubview:showImageView];
    }
    self.pageView.numberOfPages = _imageArray.count - 2;
    self.collectionView.contentOffset = CGPointMake(kScreenwidth, 0);
    [self.collectionView reloadData];
}

- (void)setIsPageView:(BOOL)isPageView {
    _isPageView = isPageView;
    if (isPageView) {
        [self addSubview:self.pageView];
    }
}

//定时器方法
- (void)timingRoll:(NSTimer *)timer {
    //使当前所在的位置加1
    NSInteger value = self.collectionView.contentOffset.x / kScreenwidth + 1;
    //偏移到下一张图片
    [self.collectionView setContentOffset:CGPointMake(value * kScreenwidth, 0) animated:YES];
    self.pageView.currentPage = [self pageValue] + 1;
    if (self.collectionView.contentOffset.x == self.collectionView.contentSize.width - 2 * kScreenwidth) {
        self.collectionView.contentOffset = CGPointMake(0, 0);
        self.pageView.currentPage = 0;
    }
}

#pragma mark  --- UICollectionViewDelegate & UICollectionViewDataSource
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopBannerTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startBannerTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageView.currentPage = [self pageValue];
    //如果滑动到最后一张图，使偏移到第2张图
    if (self.collectionView.contentOffset.x == self.collectionView.contentSize.width - kScreenwidth) {
        self.collectionView.contentOffset = CGPointMake(kScreenwidth, 0);
        self.pageView.currentPage = [self pageValue];
    } else if (self.collectionView.contentOffset.x == 0) {
        //使偏移到倒数第二张图
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentSize.width -  2 * kScreenwidth, 0);
        self.pageView.currentPage = [self pageValue];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LVMIndexRecommendAdvertisingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LVMIndexRecommendAdvertisingCollectionViewCellID forIndexPath:indexPath];
    [cell setItem:_imageArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SliderModel *model = _dataArray[indexPath.row - 1];
    HeadWebView *webView = [[HeadWebView alloc] init];
    webView.model = model;
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            CarefullyViewController *carefullyCon = (CarefullyViewController *)nextResponder;
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.25];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [[[[UIApplication sharedApplication] keyWindow] layer] addAnimation:animation forKey:nil];
            [carefullyCon.navigationController presentViewController:webView animated:NO completion:nil];
        }
    }
}

#pragma mark  --- getter & setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenwidth, self.frame.size.height);
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenwidth, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LVMIndexRecommendAdvertisingCollectionViewCell class] forCellWithReuseIdentifier:LVMIndexRecommendAdvertisingCollectionViewCellID];
    }
    return _collectionView;
}

- (UIPageControl *)pageView {
    if (!_pageView) {
        _pageView = [[UIPageControl alloc] init];
        _pageView.frame = CGRectMake(0, self.frame.size.height - pageViewHeight * kMDFScale, self.frame.size.width, pageViewHeight * kMDFScale);
        _pageView.currentPage = 0;
        _pageView.multipleTouchEnabled = NO;
        _pageView.enabled = NO;
    }
    return _pageView;
}

- (void)startBannerTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)stopBannerTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

//计算第几个page
- (NSInteger)pageValue {
    return self.collectionView.contentOffset.x / kScreenwidth - 1;
}

@end
