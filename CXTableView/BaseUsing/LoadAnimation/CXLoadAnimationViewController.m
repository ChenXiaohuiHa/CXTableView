//
//  CXLoadAnimationViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/12/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

/**
 该功能利用 TABAnimated 这个三方库
 */
#import "CXLoadAnimationViewController.h"
#import "CXLoadAnimationCell.h"
#import "TABAnimated.h"

@interface CXLoadAnimationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CXLoadAnimationViewController

/** 数据数组 */
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self loadData];
}
#pragma mark ---------- 加载数据 ----------
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.dataArray addObjectsFromArray:[self creatModelsWithCount:20]];
        self.tableView.animatedStyle = TABTableViewAnimationEnd;
        [self.tableView reloadData];
    });
}
#pragma mark ---------- tableView ----------
- (void)createTableView {
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    table.animatedStyle = TABTableViewAnimationStart;  // 开启动画
    table.animatedCount = 10;
    table.dataSource = self;
    table.delegate = self;
    table.rowHeight = 100;
    table.backgroundColor = [UIColor whiteColor];
    table.estimatedRowHeight = 0;
    table.estimatedSectionFooterHeight = 0;
    table.estimatedSectionHeaderHeight = 0;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [table registerClass:[CXLoadAnimationCell class] forCellReuseIdentifier:@"CXLoadAnimationCell"];
    [self.view addSubview:table];
    self.tableView = table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXLoadAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXLoadAnimationCell" forIndexPath:indexPath];
    
    //在加载动画的时候，即未获得数据时，不要走加载控件数据的方法
    if (_tableView.animatedStyle != TABTableViewAnimationStart) {
        cell.mode = self.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 数据
- (NSArray *)creatModelsWithCount:(NSInteger)count {
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *titleArray = @[@"google",
                            @"baidu",
                            @"wangyi",
                            @"tenxun",
                            @"ali"
                            ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *timeArray = @[@"2018-01-01 12:22:00",
                            @"2018-02-04 02:34:00",
                            @"2018-03-08 23:20:00",
                            @"2018-04-11 18:00:00",
                            @"2018-05-18 09:45:00"
                            ];
    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        CXLoadAnimationMode *model = [CXLoadAnimationMode new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.title = titleArray[contentRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.time = timeArray[contentRandomIndex];
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

@end
