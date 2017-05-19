//
//  SmallCollectView.m
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SmallCollectView.h"
#import "CollectionCell.h"
#import "Common.h"
#import "MemuViewController.h"
#import "WebViewController.h"

#define kSpace 10
static NSString *identifier = @"cellID";
@interface SmallCollectView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end


@implementation SmallCollectView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if ([super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CollectionCell class] forCellWithReuseIdentifier:identifier];
    }
    return self;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenwidth - kSpace * 2)/2, (kScreenwidth - kSpace * 2)/2+80);
}

//设置单元格边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            MemuViewController *memuVC = (MemuViewController *)nextResponder;
            UIStoryboard *storyBd = [UIStoryboard storyboardWithName:@"MemuStoryboard" bundle:nil];
            WebViewController *webVC = [storyBd instantiateViewControllerWithIdentifier:@"web_ID"];
            webVC.hidesBottomBarWhenPushed = YES;
            
            CATransition *animation = [[CATransition alloc]init];
            animation.duration = .5;
            animation.type = @"fade";
            [self.window.layer addAnimation:animation forKey:@"animation2"];

            MenuModel *model = _dataArr[indexPath.row];
            webVC.webID = model.webID;
            webVC.detailsUrl = model.detailsUrl;
            [webVC setImgUrl:model.imageUrl withTitle:model.title];
            [memuVC presentViewController:webVC animated:YES completion:nil];
            break;
        }
    }
}

@end
