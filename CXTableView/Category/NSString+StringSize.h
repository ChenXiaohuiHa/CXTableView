//
//  NSString+StringSize.h
//  DynamicRowHeightDemo
//
//  Created by 陈晓辉 on 2017/12/11.
//  Copyright © 2017年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

/**
 *  简单计算textsize
 *
 *  @param width 传入特定的宽度
 *  @param font  字体
 */
- (CGSize)hw_sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

@end
