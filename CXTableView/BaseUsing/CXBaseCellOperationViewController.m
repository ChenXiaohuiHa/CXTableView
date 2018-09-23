//
//  CXBaseCellOperationViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/23.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBaseCellOperationViewController.h"

@interface CXBaseCellOperationViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CXBaseCellOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"增删移";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [self getData];
    [self loadTableView];
}
#pragma mark ---------- 数据源 ----------
- (NSArray *)getData {

    return @[
             @{@"title":@"移动/增加/删除 cell",@"vcName":@"CXBaseCellOperationViewController"},
             @{@"title":@"自适应高度",@"vcName":@"CXCustomCellViewController"},
             @{@"title":@"联动",@"vcName":@"CXAnimationCellViewController"}
             ];
}

- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.0f;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    cell.detailTextLabel.text = _dataArray[indexPath.row][@"vcName"];
    return cell;
}

@end
