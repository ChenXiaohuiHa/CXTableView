//
//  NSArray+Safe.m
//  DynamicRowHeightDemo
//
//  Created by 陈晓辉 on 2017/12/11.
//  Copyright © 2017年 陈晓辉. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)hw_safeObjectAtIndex:(NSUInteger)index{
    if(self.count == 0) {
        NSLog(@"--- mutableArray have no objects ---");
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- index:%li out of mutableArray range ---", (long)index);
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

@end
