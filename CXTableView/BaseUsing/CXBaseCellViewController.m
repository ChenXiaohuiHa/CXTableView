//
//  CXBaseCellViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBaseCellViewController.h"

/**r、g、b为整数，alpha为0-1之间的数 */
#define RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface CXBaseCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXBaseCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
}
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
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    cell.backgroundColor = indexPath.row %2 == 0 ? [UIColor whiteColor]:RGB_Alpha(248, 248, 248, 1);
    
    return cell;
}



@end
