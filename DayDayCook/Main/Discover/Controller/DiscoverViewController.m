//
//  DiscoverViewController.m
//  DayDayCook
//
//  Created by mac on 16/10/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Common.h"
#import "KFCDataService.h"
#import "QiCircleScroll.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "UIView+LoadView.h"
#import "AFNetworking.h"

static NSString *identifier = @"cellID";
static NSString *HeadIdentifier = @"headID";

@interface DiscoverViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectView;
    UIView *_loadView;
}
@property (nonatomic,strong)NSDictionary *dataDic;

@end


@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadData];
    
    _loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight-64-49)];
    _loadView.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"发现";
    [self.view addSubview:_loadView];
    [_loadView beginLoading];
    
}

-(void)_loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.daydaycook.com.cn/daydaycook/recommend/getMoreThemeRecipe.do" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        _dataDic = dic;
        [self _createColloctionView];
        [_loadView endLoading];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)_createColloctionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, kScreenheight-64-49) collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectView];
    layout.itemSize = CGSizeMake((kScreenwidth-6)/2, (kScreenwidth-6)/2);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    _collectView.dataSource = self;
    _collectView.delegate = self;
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = [_dataDic allKeys];
    return arr.count-1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSArray *arr = _dataDic[[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    NSDictionary *imgDic = [arr lastObject];
    NSString *imgURL = imgDic[@"image_url"];
    NSString *title = imgDic[@"locationName"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    [cell.contentView addSubview:imgView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = [NSString stringWithFormat:@"#%@",title];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.center = imgView.center;
    [imgView addSubview:label];
    return cell;
}

//设置组的头视图的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 200);
}

//头视图的重用
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadIdentifier forIndexPath:indexPath];
    NSArray *array = _dataDic[@"-1"];
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSString *urlStr = dic[@"image_url"];
        [imgArr addObject:urlStr];
    }
    NSArray *arr = [NSArray arrayWithArray:[imgArr mutableCopy]];
    QiCircleScroll *cirleView = [[QiCircleScroll alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, 200)];
    cirleView.imgArr = arr;
    cirleView.circleCount = 3;
    [headView addSubview:cirleView];
    return headView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = _dataDic[[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    NSDictionary *imgDic = [arr lastObject];
    NSString *idURL = imgDic[@"recipe_id"];
    NSString *imgURL = imgDic[@"image_url"];
    NSString *title = imgDic[@"locationName"];
    UIStoryboard *storyBd = [UIStoryboard storyboardWithName:@"MemuStoryboard" bundle:nil];
    WebViewController *webVC = [storyBd instantiateViewControllerWithIdentifier:@"web_ID"];
    webVC.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [[CATransition alloc]init];
    animation.duration = .5;
    animation.type = @"fade";
    [self.view.window.layer addAnimation:animation forKey:@"animation2"];
    webVC.webID = idURL;
    webVC.detailsUrl = nil;
    [webVC setImgUrl:imgURL withTitle:title];
    [self presentViewController:webVC animated:YES completion:nil];
}

@end
