//
//  FoodCollectionCell.m
//  DayDayCook
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FoodCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface FoodCollectionCell ()

@property(nonatomic,strong)UIImageView *foodImage;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *descriptionDoing;
@property(nonatomic,strong)UILabel *clickNumber;
@end

@implementation FoodCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _foodImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _foodImage.contentMode = UIViewContentModeScaleAspectFill;
        _foodImage.layer.masksToBounds = YES;
        _foodImage.layer.cornerRadius = 0.4;
        _foodImage.clipsToBounds = YES;
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5 * kMDFScale, CGRectGetMaxY(_foodImage.frame) + 5 * kMDFScale, frame.size.width - 10, 20 * kMDFScale)];
        _titleLable.font = [UIFont boldSystemFontOfSize:17 * kMDFScale];
        
        _descriptionDoing = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_titleLable.frame), CGRectGetMaxY(_titleLable.frame)+ 10 * kMDFScale, CGRectGetWidth(_titleLable.frame), 10 * kMDFScale)];
        _descriptionDoing.font = [UIFont systemFontOfSize:12 * kMDFScale];
        _descriptionDoing.textColor = [UIColor grayColor];
        
        UIButton *storeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        storeBut.frame = CGRectMake(CGRectGetMinX(_descriptionDoing.frame) + 10 * kMDFScale, CGRectGetMaxY(_descriptionDoing.frame) + 8 * kMDFScale, 16 * kMDFScale, 13 * kMDFScale);
        [storeBut setImage:[UIImage imageNamed:@"live_history_favorite~iphone.png"] forState:UIControlStateNormal];
        storeBut.contentMode = UIViewContentModeScaleAspectFit;
        
        UIImageView *eyeView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(storeBut.frame) + 10 * kMDFScale, CGRectGetMinY(storeBut.frame), 20 * kMDFScale, 13 * kMDFScale)];
        eyeView.image = [UIImage imageNamed:@"live_history_click~iphone.png"];
        
        _clickNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(eyeView.frame) + 10 * kMDFScale, CGRectGetMinY(eyeView.frame), 100 * kMDFScale, CGRectGetHeight(eyeView.frame))];
        _clickNumber.font = [UIFont systemFontOfSize:12 * kMDFScale];
        _clickNumber.textAlignment = NSTextAlignmentLeft;
        _clickNumber.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_foodImage];
        [self.contentView addSubview:_titleLable];
        [self.contentView addSubview:_descriptionDoing];
        [self.contentView addSubview:storeBut];
        [self.contentView addSubview:eyeView];
        [self.contentView addSubview:_clickNumber];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor grayColor]CGColor];
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setModel:(CollectionModel *)model{
    _model = model;
    [self creatImage];
}

-(void)creatImage{
    [_foodImage sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    _titleLable.text = _model.title;
    _descriptionDoing.text = _model.descriptionDoing;
    _clickNumber.text = _model.click_count;
}

@end
