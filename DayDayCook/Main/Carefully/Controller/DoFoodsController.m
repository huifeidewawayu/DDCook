//
//  DoFoodsController.m
//  DayDayCook
//
//  Created by wurui on 17/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DoFoodsController.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DoFoodsController () <UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *clickImage;
@property (nonatomic, strong) UILabel *clickLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *shoppingButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UITextField *commentTextFL;

@end

@implementation DoFoodsController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.view.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
//    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
//    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
//    if (!self.navigationController.navigationBar.isTranslucent) {
//        if (backgroundImageView != nil && backgroundImageView.image != nil) {
//            barBackgroundView.alpha = 0;
//        } else {
//            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
//            if (backgroundEffectView != nil) {
//                backgroundEffectView.alpha = 0;
//            }
//        }
//    } else {
//        barBackgroundView.alpha = 0;
//    }
//    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)setupSubViews {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.backButton];
    [self.scrollView addSubview:self.headImage];
    [self.headImage addSubview:self.playButton];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.clickImage];
    [self.scrollView addSubview:self.clickLabel];
    [self.scrollView addSubview:self.descriptionLabel];
    [self.bottomView addSubview:self.collectButton];
    [self.bottomView addSubview:self.shoppingButton];
    [self.bottomView addSubview:self.commentButton];
    [self.bottomView addSubview:self.commentTextFL];
    CGRect backButtonFrame = CGRectMake(20 * kMDFScale, 40 * kMDFScale, 30 * kMDFScale, 30 * kMDFScale);
    self.backButton.frame = backButtonFrame;
    CGRect headImageFrame = CGRectMake(0, -20, kScreenwidth, kScreenheight * 0.75);
    self.headImage.frame = headImageFrame;
    CGRect playButtonFrame = CGRectMake(0, 0, 50 * kMDFScale, 50 * kMDFScale);
    self.playButton.frame = playButtonFrame;
    self.playButton.center = self.headImage.center;
    CGRect titleLabelFrame = CGRectMake(20 * kMDFScale, CGRectGetMaxY(headImageFrame) + 10 * kMDFScale, kScreenwidth - 40 * kMDFScale, 20 * kMDFScale);
    self.titleLabel.frame = titleLabelFrame;
    CGRect clickImageFrame = CGRectMake(CGRectGetMinX(titleLabelFrame), CGRectGetMaxY(titleLabelFrame) + 7 * kMDFScale, 20 * kMDFScale, 13 * kMDFScale);
    self.clickImage.frame = clickImageFrame;
    CGRect clickLabelFrame = CGRectMake(CGRectGetMaxX(clickImageFrame) + 10 * kMDFScale, CGRectGetMinY(clickImageFrame), 150 * kMDFScale, 13 * kMDFScale);
    self.clickLabel.frame = clickLabelFrame;
    CGRect descriptionLabelFrame = CGRectMake(CGRectGetMinX(clickImageFrame), CGRectGetMaxY(clickImageFrame) + 30 * kMDFScale, kScreenwidth - 2 * CGRectGetMinX(clickImageFrame), 30 * kMDFScale);
    self.descriptionLabel.frame = descriptionLabelFrame;
    CGRect bottomViewFrame = CGRectMake(-1, kScreenheight - 49, kScreenwidth + 2, 50);
    self.bottomView.frame = bottomViewFrame;
    CGRect collectButtonFrame = CGRectMake(CGRectGetMinX(clickImageFrame), 10 * kMDFScale, 25 * kMDFScale, 25 * kMDFScale);
    self.collectButton.frame = collectButtonFrame;
    CGRect shoppingButtomFrame = CGRectMake(CGRectGetMaxX(collectButtonFrame) + 30 * kMDFScale, CGRectGetMinY(collectButtonFrame), 25 * kMDFScale, 25 * kMDFScale);
    self.shoppingButton.frame = shoppingButtomFrame;
    CGRect commentButtonFrame = CGRectMake(CGRectGetMaxX(shoppingButtomFrame) + 30 * kMDFScale, CGRectGetMinY(collectButtonFrame), 25 * kMDFScale, 25 * kMDFScale);
    self.commentButton.frame = commentButtonFrame;
    CGRect commentTextFLFrame = CGRectMake(CGRectGetMaxX(commentButtonFrame) + 30 * kMDFScale, CGRectGetMinY(collectButtonFrame), kScreenwidth - CGRectGetMaxX(commentButtonFrame) - 40 * kMDFScale, 25 * kMDFScale);
    self.commentTextFL.frame = commentTextFLFrame;
    
    CGRect scrollViewFrame = CGRectMake(0, 0, kScreenwidth, kScreenheight - 49);
    self.scrollView.frame = scrollViewFrame;
    self.scrollView.contentSize = CGSizeMake(kScreenwidth, CGRectGetMaxY(descriptionLabelFrame) + 10);
};

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playVideo {
    if (_model.detailsUrl) {
        AVPlayerViewController *playCon = [[AVPlayerViewController alloc] init];
        playCon.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_model.detailsUrl]];
        [playCon.player play];
        [self.navigationController presentViewController:playCon
                                                animated:YES
                                              completion:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    self.scrollView.transform = CGAffineTransformMakeTranslation(0, -height);
    self.bottomView.transform = CGAffineTransformMakeTranslation(0, -height);

}

#pragma mark  --- 手势方法
- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.transform = CGAffineTransformMakeTranslation(0, 0);
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    [self.commentTextFL resignFirstResponder];
}

#pragma mark  --- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.transform = CGAffineTransformMakeTranslation(0, 0);
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    [textField resignFirstResponder];
    return true;
}

#pragma mark  --- setter & getter
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back_icon~iphone"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.contentMode = UIViewContentModeScaleAspectFill;
        _headImage.userInteractionEnabled = YES;
    }
    return _headImage;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.hidden = YES;
        [_playButton setImage:[UIImage imageNamed:@"play~iphone"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)];
        tapGesture.delegate = self;
        [_scrollView addGestureRecognizer:tapGesture];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17 * kMDFScale weight:2];
    }
    return _titleLabel;
}

- (UILabel *)clickLabel {
    if (!_clickLabel) {
        _clickLabel = [[UILabel alloc] init];
        _clickLabel.font = [UIFont systemFontOfSize:13 * kMDFScale];
        _clickLabel.textColor = [UIColor grayColor];
    }
    return _clickLabel;
}

- (UIImageView *)clickImage {
    if (!_clickImage) {
        _clickImage = [[UIImageView alloc] init];
        _clickImage.image = [UIImage imageNamed:@"live_history_click~iphone.png"];
    }
    return _clickImage;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:14 * kMDFScale];
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.borderWidth = 0.3;
        _bottomView.layer.borderColor = [[UIColor grayColor] CGColor];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setImage:[UIImage imageNamed:@"personal_collect_icon~iphone"] forState:UIControlStateNormal];
        _collectButton.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _collectButton;
}

- (UIButton *)shoppingButton {
    if (!_shoppingButton) {
        _shoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shoppingButton setImage:[UIImage imageNamed:@"shopping~iphone"] forState:UIControlStateNormal];
        _shoppingButton.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shoppingButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"icon-评论~iphone"] forState:UIControlStateNormal];
        _commentButton.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _commentButton;
}

- (UITextField *)commentTextFL {
    if (!_commentTextFL) {
        _commentTextFL = [[UITextField alloc] init];
        CGFloat colorFloat = 231.0/255.0;
        _commentTextFL.backgroundColor = [UIColor colorWithRed:colorFloat green:colorFloat blue:colorFloat alpha:0.65];
        _commentTextFL.layer.cornerRadius = 4;
        _commentTextFL.delegate = self;
        _commentTextFL.clearButtonMode = UITextFieldViewModeWhileEditing;
        _commentTextFL.placeholder = @"评论...";
    }
    return _commentTextFL;
}

- (void)setModel:(CollectionModel *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    if (_model.detailsUrl) {
        self.playButton.hidden = NO;
    }
    self.titleLabel.text = _model.title;
    self.clickLabel.text = _model.click_count;
    self.descriptionLabel.text = _model.descriptionDoing;
    CGRect rect = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(kScreenwidth - 2 * CGRectGetMinX(self.clickImage.frame), 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * kMDFScale]} context:nil];
    CGFloat height = rect.size.height;
    self.descriptionLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x, self.descriptionLabel.frame.origin.y, self.descriptionLabel.frame.size.width, height);
    self.scrollView.contentSize = CGSizeMake(kScreenwidth, CGRectGetMaxY(self.descriptionLabel.frame) + 10);
}

@end
