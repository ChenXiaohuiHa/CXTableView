//
//  CXLoadAnimationMode.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/12/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXLoadAnimationMode : NSObject

/** icon */
@property (nonatomic, copy) NSString *iconName;
/** title */
@property (nonatomic, copy) NSString *title;
/** name */
@property (nonatomic, copy) NSString *name;
/** time */
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
