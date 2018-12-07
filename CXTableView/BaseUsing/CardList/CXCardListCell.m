//
//  CXCardListCell.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/12/6.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCardListCell.h"
#import "Masonry.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)//界面的宽度
#define kRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define kRandomColor arc4random_uniform(255)//随机数

@interface CXCardListCell ()

/** 阴影背景 */
@property (nonatomic, strong) UIView *shadowBgView;
/** 背景颜色 */
@property (nonatomic, strong) UIView *cardBgView;
/** 小 logo 背景图标 */
@property (nonatomic, strong) UIView *miniLogoBgView;
/** 小图标 */
@property (nonatomic, strong) UIImageView *miniLogo;
/** 卡名字 */
@property (nonatomic, strong) UILabel *cardNameLabel;
/** 卡号 */
@property (nonatomic, strong) UILabel *cardNumberLabel;
/** 最新的 new 标志 */
@property (nonatomic, strong) UIImageView *latestImageView;
/** 颜色渐变 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end
@implementation CXCardListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        [self makeConstraint];
    }
    return self;
}
#pragma mark ---------- UI ----------
- (void)setUpUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    //阴影背景
    [self.contentView addSubview:self.shadowBgView];
    //背景颜色
    [self.shadowBgView addSubview:self.cardBgView];
    //logo
    [self.cardBgView addSubview:self.miniLogoBgView];
    //小图标
    [self.cardBgView addSubview:self.miniLogo];
    //卡名字
    [self.cardBgView addSubview:self.cardNameLabel];
    //卡号
    [self.cardBgView addSubview:self.cardNumberLabel];
    //标志
    [self.cardBgView addSubview:self.latestImageView];
}
//MARK: 阴影背景
- (UIView *)shadowBgView {
    if (!_shadowBgView) {
        _shadowBgView = [[UIView alloc] init];
        _shadowBgView.backgroundColor = [UIColor clearColor];
        _shadowBgView.layer.shadowOffset = CGSizeMake(0, -2);
        _shadowBgView.layer.shadowOpacity = 0.2;
        _shadowBgView.layer.shadowRadius = 4;
    }
    return _shadowBgView;
}
//MARK: 背景颜色
- (UIView *)cardBgView {
    if (!_cardBgView) {
        _cardBgView = [[UIView alloc] init];
        [_cardBgView.layer addSublayer:self.gradientLayer];
        _cardBgView.layer.shadowColor = [UIColor blackColor].CGColor;
        _cardBgView.layer.cornerRadius = 7.0f;
        _cardBgView.layer.masksToBounds = YES;
    }
    return _cardBgView;
}
//MARK: logo
- (UIView *)miniLogoBgView {
    if (!_miniLogoBgView) {
        _miniLogoBgView = [[UIView alloc] init];
        _miniLogoBgView.backgroundColor = [UIColor whiteColor];
        _miniLogoBgView.layer.cornerRadius = 21.0f;
        _miniLogoBgView.layer.masksToBounds = YES;
    }
    return _miniLogoBgView;
}
//MARK: 小图标
- (UIImageView *)miniLogo {
    if (!_miniLogo) {
        _miniLogo = [[UIImageView alloc] init];
        _miniLogo.image = [UIImage imageNamed:@"bankVerify_cmb"];
    }
    return _miniLogo;
}
//MARK: 卡名字
- (UILabel *)cardNameLabel {
    if (!_cardNameLabel) {
        _cardNameLabel = [[UILabel alloc] init];
        _cardNameLabel.textAlignment = NSTextAlignmentLeft;
        _cardNameLabel.font = [UIFont systemFontOfSize:16.f];
        _cardNameLabel.textColor = [UIColor blackColor];
        _cardNameLabel.text = @"招商银行";
    }
    return _cardNameLabel;
}
//MARK: 卡号
- (UILabel *)cardNumberLabel {
    if (!_cardNumberLabel) {
        _cardNumberLabel = [[UILabel alloc] init];
        _cardNumberLabel.font = [UIFont systemFontOfSize:15.f];
        _cardNumberLabel.textColor = [UIColor greenColor];
        _cardNumberLabel.adjustsFontSizeToFitWidth = YES;
        _cardNumberLabel.textAlignment = NSTextAlignmentLeft;
        _cardNumberLabel.attributedText = [self cardInfoAttriString];
    }
    return _cardNumberLabel;
}
//MARK: 标志
- (UIImageView *)latestImageView {
    if (!_latestImageView) {
        _latestImageView = [[UIImageView alloc] init];
    }
    return _latestImageView;
}
//MARK: 颜色渐变
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)kRGB(kRandomColor, kRandomColor, kRandomColor).CGColor,(__bridge id)kRGB(kRandomColor, kRandomColor, kRandomColor).CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        _gradientLayer.frame = CGRectMake(0, 0, kScreenWidth-25, 90);
    }
    return _gradientLayer;
}

#pragma mark ---------- Other Method ----------
//MARK: 富文本
- (NSMutableAttributedString *)cardInfoAttriString {
    
    NSString *cardnoSub = @"7705";
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"＊＊＊＊ ＊＊＊＊ ＊＊＊＊ %@",cardnoSub]];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:[attriStr.string rangeOfString:@"＊＊＊＊ ＊＊＊＊ ＊＊＊＊"]];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.f] range:[attriStr.string rangeOfString:cardnoSub]];
    
    return attriStr;
}

#pragma mark ---------- UI 控件添加约束 ----------
- (void)makeConstraint {
    
    [self.shadowBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(12.5);
        make.right.mas_equalTo(self.contentView).offset(-12.5);
        make.height.mas_equalTo(100);
    }];
    [self.cardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shadowBgView);
        make.left.mas_equalTo(self.shadowBgView);
        make.right.mas_equalTo(self.shadowBgView);
        make.height.mas_equalTo(100);
    }];
    [self.miniLogoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardBgView).offset(29);
        make.left.mas_equalTo(self.cardBgView).offset(20);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    [self.miniLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.miniLogoBgView);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(30);
        make.left.mas_equalTo(self.miniLogo.mas_right).offset(10);
        make.right.mas_equalTo(self.cardBgView).offset(-15);
        make.height.mas_equalTo(16);
    }];
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardNameLabel.mas_bottom).offset(6);
        make.left.right.mas_equalTo(self.cardNameLabel);
        make.height.mas_equalTo(20);
    }];
    [self.latestImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardBgView);
        make.right.mas_equalTo(self.cardBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}


@end
