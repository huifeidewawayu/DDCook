//
//  CollectionCell.m
//  DayDayCook
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CollectionCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@interface CollectionCell ()

@property (nonatomic,strong)UIImageView *postImgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *introduceLabel;
@property (nonatomic,strong)UIButton *loveBtn;
@property (nonatomic,strong)UIImageView *eyeImgView;
@property (nonatomic,strong)UILabel *numLabel;

@end


@implementation CollectionCell

-(UIImageView *)postImgView{
    if (_postImgView == nil) {
        _postImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _postImgView.contentMode = UIViewContentModeScaleAspectFill;
        _postImgView.clipsToBounds = YES;
        [self.contentView addSubview:_postImgView];
    }
    return _postImgView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)introduceLabel{
    if (_introduceLabel == nil) {
        _introduceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _introduceLabel.textColor = [UIColor grayColor];
        _introduceLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_introduceLabel];
    }
    return _introduceLabel;
}

-(UIButton *)loveBtn{
    if (_loveBtn == nil) {
        _loveBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_loveBtn setImage:[UIImage imageNamed:@"like~iphone"] forState:UIControlStateNormal];
        [self.contentView addSubview:_loveBtn];
    }
    return _loveBtn;
}

-(UIImageView *)eyeImgView{
    if (_eyeImgView == nil) {
        _eyeImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _eyeImgView.image = [UIImage imageNamed:@"live_history_click~iphone"];
        [self.contentView addSubview:_eyeImgView];
    }
    return _eyeImgView;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _numLabel.textColor = [UIColor grayColor];
        _numLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_numLabel];
    }
    return _numLabel;
}

-(void)setModel:(MenuModel *)model{
    _model = model;
    
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;

    self.postImgView.frame = CGRectMake(0, 0, self.width, self.width);
    [_postImgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    
    self.titleLabel.frame = CGRectMake(5, CGRectGetMaxY(_postImgView.frame), self.width-5, 30);
    _titleLabel.text = model.title;
    
    self.introduceLabel.frame = CGRectMake(5, CGRectGetMaxY(_titleLabel.frame), self.width-5, 20);
    _introduceLabel.text = model.introduce;
    
    self.loveBtn.frame = CGRectMake(10, CGRectGetMaxY(_introduceLabel.frame)+10, 15, 15);
    
    self.eyeImgView.frame = CGRectMake(40, CGRectGetMaxY(_introduceLabel.frame)+10, 20, 15);
    
    self.numLabel.frame = CGRectMake(80, CGRectGetMaxY(_introduceLabel.frame)+10, 50, 15);
    _numLabel.text = model.clickCount;
}

@end
