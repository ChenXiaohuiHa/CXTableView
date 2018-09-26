//
//  CXMenuItemModel.h
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/25.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMenuItemModel : NSObject

/** 正常状态下图片 */
@property (nonatomic, copy) NSString *normalImageName;
/** 高亮状态下图片 */
@property (nonatomic, copy) NSString *highLightedImageNale;
/** 选中状态下图片 */
@property (nonatomic, copy) NSString *selectedImageName;
/** 菜单item的标题 */
@property (nonatomic, copy) NSString *itemText;

@end
