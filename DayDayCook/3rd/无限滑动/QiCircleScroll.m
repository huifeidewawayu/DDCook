//
//  QiCircleScroll.m
//  123123
//
//  Created by ouyangqi on 16/10/25.
//  Copyright © 2016年 ouyangqi. All rights reserved.
//

#import "QiCircleScroll.h"
#import "UIImageView+WebCache.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface QiCircleScroll ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageCon;
    //宽和高
    CGFloat scrollWidth;
    CGFloat scrollHeight;
}
@end


@implementation QiCircleScroll


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        scrollHeight = self.frame.size.height;
        scrollWidth = self.frame.size.width;

    }
    return self;
}


-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:_imgArr[0]];
    for (NSString *imgStr in _imgArr) {
        [arr addObject:imgStr];
    }
    [arr addObject:arr[_imgArr.count-1]];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    _scrollView.contentSize = CGSizeMake(scrollWidth*arr.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(scrollWidth, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];

    
    
    for (int i=0; i<arr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollWidth*i, 0, scrollWidth, scrollHeight)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        [_scrollView addSubview:imgView];
    }
    
    _pageCon = [[UIPageControl alloc]initWithFrame:CGRectMake(0, scrollHeight-20, scrollWidth, 20)];
    _pageCon.numberOfPages = _imgArr.count;
    [self addSubview:_pageCon];
    [_pageCon addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)setCircleCount:(NSInteger)circleCount{
    _circleCount = circleCount;
    if (_circleCount) {
        CADisplayLink *displayLine = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaylineMethod:)];
        [displayLine addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }

}


-(void)displaylineMethod:(CADisplayLink *)link{
    static int count = 0;
    count ++;
    if (count%(60*_circleCount) == 0) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+scrollWidth, 0) animated:YES];
        //NSLog(@"%d",count%60);
    }

}


//点击事件
-(void)pageAction:(UIPageControl *)pageCo{
    
    
    [_scrollView setContentOffset:CGPointMake(scrollWidth*(pageCo.currentPage+1), 0) animated:YES];
}

#pragma mark - 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollWidth;
//    NSLog(@"%ld",index);
    
    if (index==_imgArr.count+1) {
        _pageCon.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(scrollWidth, 0)];
    }else if (scrollView.contentOffset.x == 0){
        _pageCon.currentPage = _imgArr.count-1;
        [scrollView setContentOffset:CGPointMake(scrollWidth*_imgArr.count, 0)];
    }else{
        _pageCon.currentPage = index-1;
    }
    
//    NSLog(@"%ld",_pageCon.currentPage);
}


@end
