//
//  CXCustomHeightCell.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/23.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCustomHeightCell.h"
#import "SDAutoLayout.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 55; // 根据具体font而定
@implementation CXCustomHeightCell {
    UILabel *_contentLabel;//内容
    UIButton *_moreButton;//全文
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpCell];
    }
    return self;
}
- (void)setUpCell {
    
    //内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    _contentLabel.textColor = [UIColor blueColor];
    _contentLabel.numberOfLines = 0;
    
    //全文
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到 cell上
    [self.contentView sd_addSubviews:@[_contentLabel,_moreButton]];
    
    //添加约束
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _contentLabel.sd_layout.topSpaceToView(contentView, margin).leftSpaceToView(contentView, margin).rightSpaceToView(contentView, margin).autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout.topSpaceToView(_contentLabel, 0).leftEqualToView(_contentLabel).widthIs(60);
}
- (void)setModel:(CXCellHeightModel *)model {
    _model = model;
    
    //内容
    _contentLabel.text = model.msgText;
    
    //contentLabel 方法
    if (model.shouldShowMoreButton){ // 如果文字高度超过60
        
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    }else {
        
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    [self setupAutoHeightWithBottomView:_moreButton bottomMargin:15];
}


//点击 全文
- (void)moreButtonAction:(UIButton *)sender {
    
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}




@end
