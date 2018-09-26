//
//  CXMenuCell.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXMenuCell.h"
#import "SDAutoLayout.h"
#import "CXMenuButton.h"

#define menu_item_space  5
#define menu_item_whide  ([[UIScreen mainScreen] bounds].size.width - 6*5)/5
#define menu_item_height 50
#define max_item_count   5

#define device_width     [[UIScreen mainScreen] bounds].size.width

@interface CXMenuCell ()

/** 下拉菜单数据源*/
@property (nonatomic, strong) NSArray *menuItemArray;
/** 是否已经绘制了下拉菜单*/
@property (nonatomic, assign) BOOL isAlreadyDrawMenu;

@end

@implementation CXMenuCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //设置单元格菜单是否被打开，其实可以直接使用isSelected代替。
    self.isOpenMenu = YES;
    //self.isOpenMenu = selected;
    //NSLog(@"--%d",selected);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //最重要的一句代码！没有的话单元格直接全部显示下拉菜单了！两句随便选一句
        //self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        [self customCell];
    }
    return self;
}

/**
 *  自定义 Cell 中控件属性
 */
- (void)customCell {
    
//图像图片
    self.headImageView = [[UIImageView alloc] init];
    //设置头像圆角
    self.headImageView.layer.cornerRadius = 25;
    self.headImageView.layer.masksToBounds = YES;
    
//内容 标签
    self.indexPathLabel = [[UILabel alloc] init];
    
//下拉菜单按钮
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setImage:[UIImage imageNamed:@"cm2_list_btn_more"] forState:UIControlStateNormal];
    //绑定事件
    [self.moreBtn addTarget:self
                     action:@selector(moreClick:)
           forControlEvents:UIControlEventTouchUpInside];
    
//下拉菜单视图
    self.menuView = [[UIView alloc] init];
    self.menuView.backgroundColor  = [UIColor blackColor];
    
    [self.contentView sd_addSubviews:@[self.headImageView,self.indexPathLabel,self.moreBtn,self.menuView]];
    
//添加约束
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    self.headImageView.sd_layout.topSpaceToView(contentView, margin).leftSpaceToView(contentView, margin).widthIs(50).heightIs(50);
    self.indexPathLabel.sd_layout.topEqualToView(self.headImageView).leftSpaceToView(self.headImageView, 20).widthIs(200).heightIs(30);
    self.moreBtn.sd_layout.topEqualToView(self.indexPathLabel).rightSpaceToView(contentView, 20).widthIs(40).heightIs(40);
    self.menuView.sd_layout.topSpaceToView(contentView, 64).leftSpaceToView(contentView, 0).rightSpaceToView(contentView, 0).bottomSpaceToView(contentView, 0);
}

#pragma mark ---------- 构建下拉视图 ----------
- (void)buildMenuView {
    
    //避免多次挥之下拉菜单
    if (self.isAlreadyDrawMenu) {
        
        return;
    }
    
    //构建菜单
    self.menuItemArray = [NSArray array];
    if ([self.delegate respondsToSelector:@selector(dataSourceForMenuItem)]) {
        
        self.menuItemArray = [self.delegate dataSourceForMenuItem];
        
        __weak CXMenuCell *weakSelf = self;
        [self.menuItemArray enumerateObjectsUsingBlock:^(CXMenuItemModel *menuItemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx >= max_item_count) {
                
                //下拉菜单的item超过最大数(MAX_ITEM_COUNT:5)的时候就不绘制,可以自定义下拉菜单个数
                return ;
            }
            
            CGRect menuItenRect = CGRectMake(menu_item_space +(menu_item_space +menu_item_whide) *idx, 0, menu_item_whide, menu_item_height);
            
            CXMenuButton *menuItemButton = [[CXMenuButton alloc] initWithFrame:menuItenRect model:menuItemModel];
            menuItemButton.tag = idx;
            [menuItemButton addTarget:self
                               action:@selector(menuItemClick:)
                     forControlEvents:UIControlEventTouchUpInside];
            [weakSelf.menuView addSubview:menuItemButton];
        }];
    }
    
    self.isAlreadyDrawMenu = YES;
}

//MARK: 下拉菜单按钮
- (void)moreClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didOpenMenuAtCell:WithMoreButton:)]) {
        [self.delegate didOpenMenuAtCell:self WithMoreButton:sender];
    }
}

//MARK: 下拉菜单item点击事件
- (void)menuItemClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(menuCell:didSelectedItemAtIndex:)]) {
        [self.delegate menuCell:self didSelectedItemAtIndex:sender.tag];
    }
}

@end
