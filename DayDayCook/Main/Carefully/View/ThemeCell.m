//
//  ThemeCell.m
//  DayDayCook
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ThemeCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface ThemeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *describeLB;

@end

@implementation ThemeCell

-(void)setModel:(CollectionModel *)model{
    _model = model;
    [self setCellAtt];
}

-(void)setCellAtt{
    
    [_themeImage sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    _themeImage.contentMode = UIViewContentModeScaleAspectFill;
    _titleLB.text = _model.title;
    _titleLB.font = [UIFont systemFontOfSize:17 * kMDFScale];
    _describeLB.text = _model.descriptionDoing;
    _describeLB.font = [UIFont systemFontOfSize:13 * kMDFScale];
}

@end
