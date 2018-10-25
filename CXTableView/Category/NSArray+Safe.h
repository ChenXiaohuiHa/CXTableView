//
//  NSArray+Safe.h
//  DynamicRowHeightDemo
//
//  Created by 陈晓辉 on 2017/12/11.
//  Copyright © 2017年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

- (id)hw_safeObjectAtIndex:(NSUInteger)index;

@end
