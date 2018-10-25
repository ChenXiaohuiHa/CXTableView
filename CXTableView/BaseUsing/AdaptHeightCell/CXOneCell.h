//
//  CXOneCell.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/10/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXOneModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXOneCell : UITableViewCell

@property (strong ,nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) CXOneModel *model;

/**
 点击 全文, 查看全部 Block
 */
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *iPath);

@end

NS_ASSUME_NONNULL_END
