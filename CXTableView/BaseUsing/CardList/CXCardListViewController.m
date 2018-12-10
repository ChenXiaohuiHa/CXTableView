//
//  CXCardListViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/12/6.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCardListViewController.h"
#import "CXCardListCell.h"
@interface CXCardListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CXCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

#pragma mark ---------- tableView ----------
- (void)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 90;
    [tableView registerClass:[CXCardListCell class] forCellReuseIdentifier:@"CXCardListCell"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXCardListCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.zPosition = indexPath.row;
}


@end
