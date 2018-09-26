//
//  CXMenuButton.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/26.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CXMenuItemModel.h"

@interface CXMenuButton : UIButton

/**
 *  构造方法
 */
- (instancetype)initWithFrame:(CGRect)frame model:(CXMenuItemModel *)menuItemModel;

@end
