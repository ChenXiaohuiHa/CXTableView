//
//  CXOneModel.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/10/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXOneModel : NSObject

/** text */
@property (nonatomic, copy) NSString *msgText;
/** 是否需要展开 */
@property (nonatomic, assign) BOOL isOpening;
/** 展开, 收起 按钮 */
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end

NS_ASSUME_NONNULL_END
