//
//  CXCellHeightViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/23.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCellHeightViewController.h"
#import "CXCellHeightModel.h"
#import "CXCustomHeightCell.h"
#import "SDAutoLayout.h"

// iPhone X
#define CT_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
// 状态栏 高度.
#define CT_StatusBarHeight (CT_iPhoneX ? 44.f : 20.f)
//状态栏 导航栏 高度
#define CT_Nav_Status_Height ([[UIApplication sharedApplication] statusBarFrame].size.height +self.navigationController.navigationBar.frame.size.height)
#define Nav_Status_Height (CT_iPhoneX ? 88.f : 64.f)
// Tabbar 高度.
#define CT_TabbarHeight (CT_iPhoneX ? (49.f+34.f) : 49.f)
// Home Indicator
#define CT_TabbarSafeBottomMargin (CT_iPhoneX ? 34.f : 0.f)

@interface CXCellHeightViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CXCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"cell动态高度";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [self creatModelsWithCount:20];
    [self loadTableView];
}
#pragma mark ---------- 数据源 ----------
- (NSArray *)creatModelsWithCount:(NSInteger)count {
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {

        int contentRandomIndex = arc4random_uniform(5);
        
        NSString *msgContent = textArray[contentRandomIndex];
        
        CXCellHeightModel *model = [CXCellHeightModel new];
        model.msgText = msgContent;
        [resArr addObject:model];
    }
    return [resArr copy];
}
#pragma mark ---------- UI ----------
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    CXCellHeightModel *model = _dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CXCustomHeightCell class] contentViewWidth:[self cellContentViewWith]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    CXCustomHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[CXCustomHeightCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    cell.indexPath = indexPath;

    //点击 全部, 的回调
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *iPath) {

            CXCellHeightModel *model = weakSelf.dataArray[iPath.row];
            model.isOpening = !model.isOpening;

            //
            CGRect cellRect = [weakSelf.tableView rectForRowAtIndexPath:iPath];
            if (cellRect.origin.y < weakSelf.tableView.contentOffset.y +CT_Nav_Status_Height) {
                [weakSelf.tableView scrollToRowAtIndexPath:iPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            [weakSelf.tableView reloadData];
            //            [weakSelf.tableView reloadRowsAtIndexPaths:@[iPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];

    //////////////////////////////////////////////////////////////////////
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
