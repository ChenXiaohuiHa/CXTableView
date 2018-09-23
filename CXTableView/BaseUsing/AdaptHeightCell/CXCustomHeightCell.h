//
//  CXCustomHeightCell.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/23.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXCellHeightModel.h"
@interface CXCustomHeightCell : UITableViewCell

@property (strong ,nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) CXCellHeightModel *model;

/**
 点击 全文, 查看全部 Block
 */
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *iPath);

@end
