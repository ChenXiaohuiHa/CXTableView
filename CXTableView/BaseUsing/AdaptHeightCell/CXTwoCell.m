//
//  CXTwoCell.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/10/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTwoCell.h"
#import "NSString+StringSize.h"
@implementation CXTwoCell {
    
    UIImageView *_iconImgView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
}

+ (instancetype)registerCellWithTableView:(UITableView *)tableView {
    
    static NSString *idengtify_cell = @"idengtify_cell";
    CXTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:idengtify_cell];
    if (!cell) {
        cell = [[CXTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idengtify_cell];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell {
    
    //
    _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:_iconImgView];
    
    //
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 150, 20)];
    _nameLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_nameLabel];
    
    //该控件坐标在赋值时确定
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
}

#pragma mark - 赋值
- (void)setCellDataWithStatusName:(CXTwoModel *)model {
    
    _iconImgView.image = [UIImage imageNamed:model.iconName];
    _nameLabel.text = model.name;
    _contentLabel.text = model.msgContent;
    
    //根据内容计算_contentLabel高度
    CGFloat contentLabelWidth = [UIScreen mainScreen].bounds.size.width - 60; // 限制宽度
    CGFloat contentLabelHeight = [model.msgContent hw_sizeWithLabelWidth:contentLabelWidth font:[UIFont systemFontOfSize:15]].height;
    _contentLabel.frame = CGRectMake(60, 60, contentLabelWidth, contentLabelHeight);
}

#pragma mark - 计算 cell 高度
+ (CGFloat)tableView:(UITableView *)tableView rowHeightContent:(NSString *)content {
    
    CGFloat contentLabelWidth = [UIScreen mainScreen].bounds.size.width - 60; // 限制宽度
    CGFloat contentLabelHeight = [content hw_sizeWithLabelWidth:contentLabelWidth font:[UIFont systemFontOfSize:15]].height;
    return contentLabelHeight;
}



@end
