//
//  ChallengeCollection.m
//  DayDayCook
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChallengeCollection.h"
#import "ChallengeCell.h"

@interface ChallengeCollection ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation ChallengeCollection

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"Chanllenge" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _challengeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChallengeCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    collectionCell.model = _challengeArr[indexPath.row];
    return collectionCell;
}

@end
