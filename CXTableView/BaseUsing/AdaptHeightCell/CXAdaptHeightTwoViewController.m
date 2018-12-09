
//
//  CXAdaptHeightTwoViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/10/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXAdaptHeightTwoViewController.h"
#import "CXTwoCell.h"


@interface CXAdaptHeightTwoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 缓存 cell 高度 */
@property (nonatomic, strong) NSMutableDictionary *cacheHeight;

@end

@implementation CXAdaptHeightTwoViewController

/** 缓存 cell 高度 */
- (NSMutableDictionary *)cacheHeight {
    if (!_cacheHeight) {
        _cacheHeight = [NSMutableDictionary dictionary];
    }
    return _cacheHeight;
}
/** 数据数组 */
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"自适应高度Two";
    [self loadTableView];
}

#pragma mark - 加载 TableView
- (void)loadTableView {
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.estimatedRowHeight = 100;
    [self.view addSubview:table];
    self.tableView = table;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXTwoCell *cell = [CXTwoCell registerCellWithTableView:tableView];
    
    CXTwoModel *model = self.dataArray[indexPath.row];
    [cell setCellDataWithStatusName:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *cellHeight =  [self.cacheHeight objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (cellHeight) {
        
        NSLog(@"不用计算，直接返回行高了");
        return [cellHeight floatValue];
    }else{
        
        CXTwoModel *model = self.dataArray[indexPath.row];
        NSString *content = model.msgContent;
        CGFloat cellH = [CXTwoCell tableView:tableView rowHeightContent:content];
        CGFloat iconH = 70.f;//icon距上10,icon: 40, icon距下:10,内容距下:10 = 70 固定值

        [self.cacheHeight setObject:@(cellH +iconH) forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
        NSLog(@"第一次加载计算一次，每次展示都计算一次");
        return (cellH +iconH);
    }
}

#pragma mark - 数据
- (NSArray *)creatModelsWithCount:(NSInteger)count {
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        CXTwoModel *model = [CXTwoModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

@end
