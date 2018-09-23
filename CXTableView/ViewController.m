//
//  ViewController.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "ViewController.h"

/**r、g、b为整数，alpha为0-1之间的数 */
#define RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNav];
    [self loadTableView];
}
#pragma mark ---------- 数据源 ----------
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{@"title":@"基本使用",@"vcName":@"CXBaseCellViewController"},
                       @{@"title":@"cell~动画",@"vcName":@"CXAnimationCellViewController"}
                       ].copy;
    }
    return _dataArray;
}
#pragma mark ---------- UI ----------
- (void)loadNav {
    
    self.navigationItem.title = @"TableView";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
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
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_idntify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idntify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idntify];
    }
    
    cell.backgroundColor = indexPath.row %2 == 0 ? [UIColor whiteColor]:RGB_Alpha(248, 248, 248, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //每区数据
    NSDictionary *rowDic = self.dataArray[indexPath.row];
    
    //赋值
    NSMutableAttributedString *titleStr = [self markString:[NSString stringWithFormat:@"%ld.",indexPath.row+1]
                                                     color:[UIColor orangeColor]
                                                     fount:[UIFont fontWithName:@"Marker Felt" size:16]];
    //设置中文倾斜
    CGAffineTransform aTransform = CGAffineTransformMake(1, 0, tanf(5 *M_PI /180), 1, 0, 0);//设置反射, 倾斜角度
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:14].fontName matrix:aTransform];//取得系统字符并设置反射
    UIFont *font = [UIFont fontWithDescriptor:desc size:16];
    [titleStr appendAttributedString:[self markString:[NSString stringWithFormat:@"  %@",rowDic[@"title"]]
                                                color:[UIColor grayColor]
                                                fount:font]];
    cell.textLabel.attributedText = titleStr;
    cell.detailTextLabel.text = rowDic[@"vcName"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *VCName = [dic objectForKey:@"vcName"];
    Class class = NSClassFromString(VCName);
    UITabBarController *viewController = [[class alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}


//MARK: 富文本
- (NSMutableAttributedString *)markString:(NSString *)string color:(UIColor *)color fount:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    return attributedString;
}

@end
