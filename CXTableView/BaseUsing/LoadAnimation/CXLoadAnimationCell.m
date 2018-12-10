//
//  CXLoadAnimationCell.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/12/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXLoadAnimationCell.h"
//#import "TABAnimated.h"
#import "UITableViewCell+Animated.h"
#import "UIView+Animated.h"
@implementation CXLoadAnimationCell {
    
    UIImageView *_iconImageView;
    UILabel *_titleLab;
    UILabel *_nameLab;
    UILabel *_timeLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    //图片
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    [self.contentView addSubview:_iconImageView];
    
    //
    _titleLab = [[UILabel alloc] init];
    _titleLab.loadStyle = TABViewLoadAnimationLong;
    [self.contentView addSubview:_titleLab];
    
    //
    _nameLab = [[UILabel alloc] init];
    _nameLab.loadStyle = TABViewLoadAnimationShort;
    [self.contentView addSubview:_nameLab];
    
    //
    _timeLab = [[UILabel alloc] init];
    _timeLab.loadStyle = TABViewLoadAnimationLong;
    [self.contentView addSubview:_timeLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _iconImageView.frame = CGRectMake(10, 10, 60, 60);
    _titleLab.frame = CGRectMake(80, 10, screenWidth-150, 20);
    _nameLab.frame = CGRectMake(80, 40, screenWidth-90, 20);
    _timeLab.frame = CGRectMake(80, 70, screenWidth-150, 20);
}

- (void)setMode:(CXLoadAnimationMode *)mode {
    
    _mode = mode;
    
    _iconImageView.image = [UIImage imageNamed:mode.iconName];
    _titleLab.text = mode.title;
    _nameLab.text = mode.name;
    _timeLab.text = mode.time;
}

@end
