//
//  CarefullyTableView.m
//  DayDayCook
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CarefullyTableView.h"
#import "Common.h"
#import "FoodCollection.h"
#import "ThemeCell.h"
#import "CollectionModel.h"
#import "YYModel.h"
#import "ChallengeCollection.h"
#import "ChallengeModel.h"
#import "AlwaysRollView.h"
#import "HeadAlwaysRollView.h"

@interface CarefullyTableView ()

@property (nonatomic, strong) NSMutableArray *foodsMutArr;
@property (nonatomic, strong) NSMutableArray *challengeMutArr;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFL;
@property (nonatomic, strong) UICollectionViewFlowLayout *challengeViewFL;
//@property(nonatomic,strong)WXslide *heardSlide;
@property (nonatomic, strong) HeadAlwaysRollView *heardSlide;
@end

@implementation CarefullyTableView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.userInteractionEnabled = YES;
//        创建一个头视图
        _heardSlide = [[HeadAlwaysRollView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight/3)];
        self.tableHeaderView = _heardSlide;
        [self getNewFoodsData];
        [self getChallengeData];
    }
    return self;
}

//解析json数据
-(void)getNewFoodsData{
    
    NSString *jsonFile = [[NSBundle mainBundle]pathForResource:@"NewFoods.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
    NSDictionary *newFoodsDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *newFoodsArr = newFoodsDic[@"data"];
    _foodsMutArr = [NSMutableArray array];
    for (NSDictionary *dic in newFoodsArr) {
        CollectionModel *model = [CollectionModel yy_modelWithDictionary:dic];
        [_foodsMutArr addObject:model];
    }
}

-(void)getChallengeData{
    
    NSString *jsonFile = [[NSBundle mainBundle]pathForResource:@"Challenge.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
    NSDictionary *challengeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *challengeArr = challengeDic[@"data"];
    _challengeMutArr = [NSMutableArray array];
    for (NSDictionary *dic in challengeArr) {
        ChallengeModel *model = [ChallengeModel yy_modelWithDictionary:dic];
        [_challengeMutArr addObject:model];
    }
}

//接收数据后设计头视图
-(void)setSliderArr:(NSMutableArray *)sliderArr{
    _sliderArr = sliderArr;
    [self designHeadView];
}

#pragma mark ------表视图的代理方法及数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (section == 3) {
        return 20;
    }else{
        return 1;
    }
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        UITableViewCell *challengeCell = [[UITableViewCell alloc]init];
        challengeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatChallengeCollectionViewLayout];
    
        ChallengeCollection *challengeView = [[ChallengeCollection alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kFirstSectionHeight * kMDFScale) collectionViewLayout:_challengeViewFL];
        challengeView.bounces = NO;
        challengeView.backgroundColor = [UIColor clearColor];
        challengeView.showsHorizontalScrollIndicator = NO;
        challengeView.challengeArr = _challengeMutArr;
        [challengeCell addSubview:challengeView];
        return challengeCell;
    }else if(indexPath.section == 1){
        
        UITableViewCell *newFoodCell = [[UITableViewCell alloc]init];
        newFoodCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatFoodCollectionViewLayout];
        
     FoodCollection *newCollectionView = [[FoodCollection alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kMidSectionHeight * kMDFScale) collectionViewLayout:_collectionViewFL];
        newCollectionView.backgroundColor = [UIColor clearColor];
        newCollectionView.bounces = NO;
        newCollectionView.showsHorizontalScrollIndicator = NO;
        newCollectionView.foodArr = _foodsMutArr;
        [newFoodCell.contentView addSubview:newCollectionView];
        return newFoodCell;
    }else if(indexPath.section == 2){
        
        UITableViewCell *foodsCell = [[UITableViewCell alloc]init];
        foodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatFoodCollectionViewLayout];
        
//        在单元格上面添加CollectionView
        FoodCollection *foodCollectionView = [[FoodCollection alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kMidSectionHeight * kMDFScale) collectionViewLayout:_collectionViewFL];
        foodCollectionView.backgroundColor = [UIColor clearColor];
        foodCollectionView.bounces = NO;
        foodCollectionView.showsHorizontalScrollIndicator = NO;
        foodCollectionView.foodArr = _foodMutArr;
        [foodsCell.contentView addSubview:foodCollectionView];
        return foodsCell;
    }
    
    
    ThemeCell *themeCell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    themeCell.model = _themeMutArr[indexPath.row];
    return themeCell;
}

//创建表视图的头视图为滑动视图
-(void)designHeadView{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (SliderModel *model in _sliderArr) {
        [imageArr addObject:model.path];
    }
    NSString *firstData = [imageArr lastObject];
    NSString *lastData = [imageArr firstObject];
    [imageArr insertObject:firstData atIndex:0];
    [imageArr addObject:lastData];
    _heardSlide.imageArray = imageArr;
    _heardSlide.isPageView = YES;
    _heardSlide.dataArray = _sliderArr;
}

//设置组的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!sectionHeadView) {
        sectionHeadView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        
        UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake((kScreenwidth-150)/2, 5, 150, 30)];
        sectionName.textAlignment = NSTextAlignmentCenter;
        sectionName.font = [UIFont boldSystemFontOfSize:16];
        sectionName.tag = 101;
        
        UIImageView *sectionImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(sectionName.frame)+10, 11, 17, 17)];
        sectionImage.tag = 102;
        sectionImage.contentMode = UIViewContentModeScaleAspectFill;
        [sectionHeadView addSubview:sectionName];
        [sectionHeadView addSubview:sectionImage];
    }
    
    UILabel *sectionName = (UILabel *)[sectionHeadView viewWithTag:101];
    if (section == 0) {
        sectionName.text = @"挑战日日煮";
    }else if(section == 1){
        sectionName.text = @"每日新菜馆";
    }else if(section == 2){
        sectionName.text = @"当红人气菜";
    }else{
        sectionName.text = @"美食全攻略";
    }
    
    UIImageView *sectionImage = (UIImageView *)[sectionHeadView viewWithTag:102];
    if (section == 0) {
        sectionImage.image = [UIImage imageNamed:@"icon_challenge~iphone.png"];
    }else if(section == 1){
        sectionImage.image = [UIImage imageNamed:@"icon- 每日新品~iphone.png"];
    }else if(section == 2){
        sectionImage.image = [UIImage imageNamed:@"icon－热门推荐~iphone.png"];
    }else{
        sectionImage.image = [UIImage imageNamed:@"icon－主题~iphone.png"];
    }
    sectionHeadView.contentView.backgroundColor = [UIColor whiteColor];
    return sectionHeadView;
}

//设置组的头视图和尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40 * kMDFScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kFirstSectionHeight * kMDFScale;
    }if (indexPath.section == 1 || indexPath.section == 2) {
        return kMidSectionHeight * kMDFScale;
    }
    return kLastSectionHeight * kMDFScale;
}

//创建每日新品的布局
-(void)creatFoodCollectionViewLayout{
    
    _collectionViewFL = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionViewFL.itemSize = CGSizeMake((kScreenwidth- 10 * kMDFScale) / 2, (kMidSectionHeight - 5) * kMDFScale);
    //        最小间距
    _collectionViewFL.minimumInteritemSpacing = 20 * kMDFScale;
    //        边距
    _collectionViewFL.sectionInset = UIEdgeInsetsMake(5 * kMDFScale, 5 * kMDFScale, 5 * kMDFScale, 5 * kMDFScale);
    //    垂直滑动
    //    _collectionViewFL.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    水平滑动
    _collectionViewFL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

//创建挑战日日煮的布局
-(void)creatChallengeCollectionViewLayout{
    _challengeViewFL = [[UICollectionViewFlowLayout alloc]init];
    _challengeViewFL.itemSize = CGSizeMake(kScreenwidth * 0.75, (kFirstSectionHeight - 10) * kMDFScale);
    _challengeViewFL.sectionInset = UIEdgeInsetsMake(5 * kMDFScale, 5 * kMDFScale, 5 * kMDFScale, 5 * kMDFScale);
    _challengeViewFL.minimumLineSpacing = 0 ;
    _challengeViewFL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    使组的头视图不吸附头部
    CGFloat sectionHeaderHeight = 40 * kMDFScale;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}

@end
