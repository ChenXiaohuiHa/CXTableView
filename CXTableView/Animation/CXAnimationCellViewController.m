//
//  CXAnimationCellViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXAnimationCellViewController.h"
#import "CXShowAnimationViewController.h"

/**r、g、b为整数，alpha为0-1之间的数 */
#define RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface CXAnimationCellViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 数据源 */
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CXAnimationCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"cell~动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
}
#pragma mark ---------- 数据源 ----------
- (NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = @[@"Move", @"Alpha", @"FlyInto", @"Shake", @"OverTurn", @"ToTop", @"SpringList", @"ShrinkToTop", @"LayDown", @"Rote", @"Fade", @"Flip", @"Balloon"];
    }
    return _dataArray;
}
#pragma mark ---------- UI ----------
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.0f;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
}
#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    cell.backgroundColor = indexPath.row %2 == 0 ? [UIColor whiteColor]:RGB_Alpha(248, 248, 248, 1);
    
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CXShowAnimationViewController *vc = [CXShowAnimationViewController new];
    vc.index = indexPath.row;
    vc.navigationItem.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
