//
//  CXMenuCellViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXMenuCellViewController.h"
#import "CXMenuCellModel.h"
#import "CXMenuItemModel.h"
#import "CXMenuCell.h"

@interface CXMenuCellViewController ()<UITableViewDelegate,UITableViewDataSource,CXMenuCellDelegate>

/** 列表 */
@property (strong, nonatomic) UITableView *tableView;
/** 已经打开下拉菜单的单元格 */
@property (strong, nonatomic) CXMenuCell *openedMenuCell;
/** 已经打开下拉菜单的单元格的位置 */
@property (strong, nonatomic) NSIndexPath *openedMenuCellIndex;
/** 列表数据源 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** 下拉菜单数据源 */
@property (strong, nonatomic) NSArray *menuItemArray;

@end

@implementation CXMenuCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"下拉菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [self creatModelsWithCount:10];
    self.menuItemArray = [self getItemModel];
    [self loadTableView];
}
#pragma mark ---------- 数据源 ----------
//cell 数据
- (NSMutableArray *)creatModelsWithCount:(NSInteger)count {
    
    NSArray *textArray = @[@"珂朵莉",@"阿狸",@"宫内莲华",@"晴天",@"MrGoodbye",@"WinXin",@"钉宫理惠",@"田所梓",@"一凡",@"Boom"];
    NSArray *imgArray = @[@"foxgirl.jpg",@"img_000",@"img_001",@"img_002",@"img_003",@"0",@"1",@"2",@"3",@"4"];
    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        
        int contentRandomIndex = arc4random_uniform(5);
        
        NSString *msgContent = textArray[contentRandomIndex];
        NSString *imgContent = imgArray[contentRandomIndex];
        
        CXMenuCellModel *cellModel = [[CXMenuCellModel alloc] init];
        cellModel.imageName = imgContent;
        cellModel.labelText = msgContent;
        [resArr addObject:cellModel];
    }
    return [resArr copy];
}
//菜单 item 数据
- (NSArray *)getItemModel {
    
    NSArray *norArr = @[@"cm2_lay_icn_fav",@"cm2_lay_icn_alb",@"cm2_lay_icn_dld",@"cm2_lay_icn_artist",@"cm2_lay_icn_dlt"];
    NSArray *selArr = @[@"cm2_lay_icn_fav",@"cm2_lay_icn_alb",@"cm2_lay_icn_dld",@"cm2_lay_icn_artist",@"cm2_lay_icn_dlt"];
    NSArray *textArr = @[@"收藏",@"专辑",@"下载",@"歌单",@"删除"];
    //
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        
        NSString *norImg = norArr[i];
        NSString *selImg = selArr[i];
        NSString *text = textArr[i];
        //
        CXMenuItemModel *itemModel = [CXMenuItemModel new];
        
        itemModel.normalImageName = norImg;
        itemModel.selectedImageName = selImg;
        itemModel.itemText = text;
        [array addObject:itemModel];
    }
    return array;
}
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((self.openedMenuCell != nil) && (self.openedMenuCell.isOpenMenu == YES) && (self.openedMenuCellIndex.row == indexPath.row)) {
        
        return 114.0f;
    }else{
        return 64.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    CXMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[CXMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    //设置cell自身属性(必须设置，不然收起下拉菜单动画可能有问题)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    cell.moreBtn.tag = indexPath.row;
    
    //需要手动绘制下拉菜单视图
    [cell buildMenuView];
    if (indexPath.row < self.dataArray.count) {
        
        CXMenuCellModel *cellModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.headImageView.image = [UIImage imageNamed:cellModel.imageName];
        cell.indexPathLabel.text = cellModel.labelText;
    }
    return cell;
}

#pragma mark ---------- CXMenuCellDelegate ----------
- (NSArray *)dataSourceForMenuItem {
    return self.menuItemArray;
}

#pragma mark - MenuTableViewCellDelegate
- (void)didOpenMenuAtCell:(CXMenuCell *)menuCell WithMoreButton:(UIButton *)moreButton {
    
    NSIndexPath *openedIndexPath = [NSIndexPath indexPathForRow:moreButton.tag inSection:0];
    
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == openedIndexPath.row)) {
        
        [self.tableView reloadData];
        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
        self.openedMenuCell = nil;
        self.openedMenuCellIndex = nil;
        return;
    }
    
    //刷新新的Cell
    self.openedMenuCell = menuCell;
    self.openedMenuCellIndex = openedIndexPath;
    [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
    //控制该表格滚动到指定indexPath对应的cell的顶端 中间 或者下方
    [self.tableView scrollToRowAtIndexPath:self.openedMenuCellIndex
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}

- (void)menuCell:(CXMenuCell *)menuCell didSelectedItemAtIndex:(NSInteger)menuItemIndex {
    
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == menuCell.moreBtn.tag)) {
        
        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
        self.openedMenuCell = nil;
        [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
        self.openedMenuCellIndex = nil;
    }
    
    //根据点击的下拉菜单的item触发相应的事件
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}


@end
