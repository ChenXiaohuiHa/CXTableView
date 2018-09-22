//
//  CXShowAnimationViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/22.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXShowAnimationViewController.h"
#import "CXTableViewAnimationsKit.h"

@interface CXShowAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CXShowAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNav];
    [self loadTableView];
}
#pragma mark ---------- UI ----------
- (void)loadNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTableView)];
}
- (void)reloadTableView {
    
    [CXTableViewAnimationsKit showWithAnimationType:self.index tableView:self.tableView];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.tableView.hidden = NO;
    [CXTableViewAnimationsKit showWithAnimationType:self.index tableView:self.tableView];
}
- (void)loadTableView {
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 100;
    table.hidden = YES;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    self.tableView = table;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width - 40;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 10, width, 80)];
        view.backgroundColor = [UIColor orangeColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 9.0;
        [cell.contentView addSubview:view];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
