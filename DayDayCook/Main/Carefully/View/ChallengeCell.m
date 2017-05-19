//
//  ChallengeCell.m
//  DayDayCook
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChallengeCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface ChallengeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *levelInfoLB;
@property (weak, nonatomic) IBOutlet UILabel *participantCountLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLBY;

@end


@implementation ChallengeCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(ChallengeModel *)model{
    _model = model;
    [self setCellAtt];
}

-(void)setCellAtt{
    _titleLB.text = _model.title;
    _titleLB.font = [UIFont systemFontOfSize:16 * kMDFScale];
    
    _levelInfoLB.text = _model.levelInfo;
    _levelInfoLB.font = [UIFont systemFontOfSize:12 * kMDFScale];
    _participantCountLB.text = [NSString stringWithFormat:@"%ld人参加",_model.participantCount];
    _participantCountLB.font = [UIFont systemFontOfSize:12 * kMDFScale];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.indexImgUrl]];
}

@end
