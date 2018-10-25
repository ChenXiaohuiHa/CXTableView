//
//  CXTwoCell.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/10/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTwoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXTwoCell : UITableViewCell

/** 初始化 cell */
+ (instancetype)registerCellWithTableView:(UITableView *)tableView;

/**
 *  设置cell的数据，提供接口
 *
 *  @param model 内容
 */
- (void)setCellDataWithStatusName:(CXTwoModel *)model;

/**
 *  传入每一行cell数据，返回行高，提供接口
 *
 *  @param tableView 当前展示的tableView
 *  @param content 需要计算高度的那部分内容
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
