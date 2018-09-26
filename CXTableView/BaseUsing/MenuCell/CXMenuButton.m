//
//  CXMenuButton.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/26.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXMenuButton.h"

@implementation CXMenuButton

- (id)initWithFrame:(CGRect)frame model:(CXMenuItemModel *)menuItemModel {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customWiewWithModel:menuItemModel];
    }
    return self;
}

- (void)customWiewWithModel:(CXMenuItemModel *)menuItemModel {
    
    //图片
    UIImageView *buttonImageView = [[UIImageView alloc] init];
    buttonImageView.bounds = CGRectMake(0, 0, 20, 20);
    buttonImageView.center = CGPointMake(self.frame.size.width/2, 20);
    buttonImageView.image = [UIImage imageNamed:menuItemModel.normalImageName];
    [self addSubview:buttonImageView];
    
    //文字标签
    UILabel *buttonLabel = [[UILabel alloc] init];
    buttonLabel.bounds = CGRectMake(0, 0, self.frame.size.width, 20);
    buttonLabel.center = CGPointMake(self.frame.size.width/2,  self.frame.size.height - buttonLabel.frame.size.height/2);
    buttonLabel.text = menuItemModel.itemText;
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.font = [UIFont systemFontOfSize:10];
    buttonLabel.textColor = [UIColor whiteColor];
    [self addSubview:buttonLabel];
}

@end
