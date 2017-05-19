//
//  BigMemuCell.m
//  DayDayCook
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BigMemuCell.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@interface BigMemuCell ()

@property (weak, nonatomic) IBOutlet UIImageView *postImgView;
@property (weak, nonatomic) IBOutlet UIImageView *blackImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

@end


@implementation BigMemuCell

- (void)awakeFromNib {
    
}

-(void)setModel:(MenuModel *)model{
    _model = model;
    [_postImgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"default_logo~iphone"]];
    _titleLabel.text = model.title;
    _introduceLabel.text = model.introduce;
    _timeLabel.text = model.maketime;
    _clickLabel.text = model.clickCount;
    _shareLabel.text = model.shareCount;
}

@end
