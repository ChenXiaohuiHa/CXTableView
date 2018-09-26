//
//  CXMenuCell.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXMenuCell;

@protocol CXMenuCellDelegate <NSObject>

/** items 列表数据 */
- (NSArray *)dataSourceForMenuItem;
/** 展开 items 列表 */
- (void)didOpenMenuAtCell:(CXMenuCell *)menuCell WithMoreButton:(UIButton *)moreButton;
/** 选择某个 item 事件 */
- (void)menuCell:(CXMenuCell *)menuCell didSelectedItemAtIndex:(NSInteger)menuItemIndex;

@end

@interface CXMenuCell : UITableViewCell

/** 代理属性 */
@property (nonatomic, assign) id <CXMenuCellDelegate> delegate;


/** 是否已经打开*/
@property (nonatomic, assign) BOOL isOpenMenu;

/** 头像*/
@property (nonatomic, strong) UIImageView *headImageView;
/** cell 的位置标签*/
@property (nonatomic, strong) UILabel *indexPathLabel;
/** 下拉菜单按钮*/
@property (nonatomic, strong) UIButton *moreBtn;
/** 下拉菜单视图*/
@property (nonatomic, strong) UIView *menuView;

/**
 *  自定义 Cell 中的控件属性
 */
- (void)customCell;

/**
 *  构建下拉视图
 */
- (void)buildMenuView;

@end
