//
//  FoodCollection.m
//  DayDayCook
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FoodCollection.h"
#import "Common.h"
#import "FoodCollectionCell.h"

@interface FoodCollection ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionViewLayout *foodCollectionLayout;
@end

static NSString *cell = @"cellID";
@implementation FoodCollection

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    _foodCollectionLayout = layout;
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
//        注册单元格
        [self registerClass:[FoodCollectionCell class] forCellWithReuseIdentifier:cell];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _foodArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cell forIndexPath:indexPath];
    collectionCell.backgroundColor = [UIColor clearColor];
    collectionCell.model = _foodArr[indexPath.row];
    
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaozhuan" object:_foodArr[indexPath.row]];
}

@end
