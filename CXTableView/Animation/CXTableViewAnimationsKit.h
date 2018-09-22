//
//  CXTableViewAnimationsKit.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/22.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CXTableViewAnimationsType) {
    
    CXTableViewAnimationsTypeMove = 0,
    CXTableViewAnimationsTypeAlpha,
    CXTableViewAnimationsTypeFlyInto,
    CXTableViewAnimationsTypeShake,
    CXTableViewAnimationsTypeOverTurn,
    CXTableViewAnimationsTypeToTop,
    CXTableViewAnimationsTypeSpringList,
    CXTableViewAnimationsTypeShrinkToTop,
    CXTableViewAnimationsTypeLayDown,
    CXTableViewAnimationsTypeRote,
    CXTableViewAnimationsTypeFade,
    CXTableViewAnimationsTypeFlip,
    CXTableViewAnimationsTypeBalloon,
};
@interface CXTableViewAnimationsKit : NSObject

/**
 类方法以显示tableView动画
 
 @param animationType : animation type
 @param tableView : the tableView to show animation
 */
+ (void)showWithAnimationType:(CXTableViewAnimationsType)animationType tableView:(UITableView *)tableView;




@end
