//
//  CXTableViewAnimationsKit.m
//  CXTableView
//
//  Created by 陈晓辉 on 2018/9/22.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTableViewAnimationsKit.h"
#import <objc/message.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation CXTableViewAnimationsKit

+ (void)showWithAnimationType:(CXTableViewAnimationsType)animationType tableView:(UITableView *)tableView {
    
    unsigned int count = 0;
    
    //获取当前类所有方法
    Method *methodList = class_copyMethodList(object_getClass(self.class), &count);
    
    int tag = 0;
    
    //遍历所有方法
    for (int i = 0; i < count; i++) {
        
        //取出遍历到的方法
        Method method = methodList[i];
        
        //获取该方法的方法名
        SEL selector = method_getName(method);
        
        //将遍历到的方法名转换为字符串类型
        NSString *methodName = NSStringFromSelector(selector);
        
        //判断方法名, 并执行与 类型 type 匹配的方法<局限: 方法必须从上到下的顺序来对应 tag,1,2,3 顺序>
        if ([methodName rangeOfString:@"AnimationWithTableView"].location != NSNotFound) {
            
            //如果当前遍历到的方法的 tag 与参数 animationType 相等, 则执行对应的方法, 否则 tag+1 继续遍历
            if (tag == animationType) {
                
                //发送方法的名称 和参数 的消息, 执行该方法
                ((void (*)(id, SEL, UITableView *))objc_msgSend)(self, selector, tableView);
                break;
            }
            tag++;
        }
    }
    free(methodList);
}

+ (void)moveAnimationWithTableView:(UITableView *)tableView {
    
    NSArray<UITableViewCell *> *visibleCells = tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat transTx = -kScreenWidth;
        /*
         CGAffineTransform是一个用于处理形变的类,其可以改变控件的平移、缩放、旋转等,其坐标系统采用的是二维坐标系,即向右为x轴正方向,向下为y轴正方向
         */
        //cell.transform = CGAffineTransformMakeTranslation(0, transTy);
        cell.transform = CGAffineTransformMakeTranslation(transTx, 0);//CGAffineTransformMakeTranslation实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        NSTimeInterval delay = idx * (0.4 / visibleCells.count);
        [UIView animateWithDuration:0.75                             //动画持续时间
                              delay:delay                            //动画延迟执行的时间
             usingSpringWithDamping:0.6                              //震动效果，范围0~1，数值越小震动效果越明显
              initialSpringVelocity:0                                //初始速度，数值越大初始速度越快
                            options:UIViewAnimationOptionCurveEaseOut //动画的过渡效果
                         animations:^{
                             
                             //执行的动画
                             cell.transform = CGAffineTransformIdentity;
                         } completion:NULL];
    }];
}

+ (void)alphaAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    CGFloat totalTime = 1.0f;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = cells[i];
        
        cell.alpha = 0.0f;
        
        [UIView animateWithDuration:totalTime                         //动画持续时间
                              delay:i*(totalTime/cells.count)         //动画延迟执行的时间
             usingSpringWithDamping:0.7                               //震动效果，范围0~1，数值越小震动效果越明显
              initialSpringVelocity:1/0.7                             //初始速度，数值越大初始速度越快
                            options:UIViewAnimationOptionLayoutSubviews  //动画的过渡效果
                         animations:^{
                             
                             //执行的动画
                             cell.alpha = 1.0f;
                         } completion:^(BOOL finished) {
                             //动画执行完毕后的操作
                         }];
    }
}

+ (void)flyIntoAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    CGFloat totalTime = 1.0f;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = cells[i];
        
        cell.transform = CGAffineTransformMakeTranslation(kScreenWidth, kScreenHeight);
        
        [UIView animateWithDuration:totalTime                         //动画持续时间
                              delay:(i)*(totalTime/cells.count)         //动画延迟执行的时间
                            options:UIViewAnimationOptionCurveEaseInOut  //动画的过渡效果
                         animations:^{
                             
                             cell.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             //动画执行完毕后的操作
                         }];
    }
}
+ (void)shakeAnimationWithTableView:(UITableView *)tableView {
    
    NSArray<UITableViewCell *> *visibleCells = tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat transTy = idx % 2 ? -kScreenHeight : kScreenHeight;
        cell.transform = CGAffineTransformMakeTranslation(transTy, 0);
        
        CGFloat delay = idx * (1 / visibleCells.count);
        //        NSTimeInterval delay = idx * 0.025;
        
        [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.75 initialSpringVelocity:1/0.75 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

+ (void)overTurnAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        cell.layer.opacity = 0.0;
        cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        NSTimeInterval totalTime = 0.7;
        [UIView animateWithDuration:0.3 delay:i*(totalTime/cells.count) options:0 animations:^{
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
+ (void)toTopAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    
    NSTimeInterval totalTime = 0.8;
    
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [tableView.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(0,  kScreenHeight);
        [UIView animateWithDuration:0.35 delay:i*(totalTime/cells.count) options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
+ (void)springListAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        cell.layer.opacity = 0.7;
        cell.layer.transform = CATransform3DMakeTranslation(0, -kScreenHeight, 20);
        NSTimeInterval totalTime = 1.0;
        
        [UIView animateWithDuration:0.4 delay:i*(totalTime/cells.count) usingSpringWithDamping:0.65 initialSpringVelocity:1/0.65 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
        } completion:^(BOOL finished) {
            
        }];
    }
}
+ (void)shrinkToTopAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = [cell convertRect:cell.bounds fromView:tableView];
        cell.transform = CGAffineTransformMakeTranslation(0, -rect.origin.y);
        [UIView animateWithDuration:0.5 animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}

+ (void)layDownAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    NSMutableArray *rectArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = cell.frame;
        [rectArr addObject:[NSValue valueWithCGRect:rect]];
        rect.origin.y = i * 10;
        cell.frame = rect;
        cell.layer.transform = CATransform3DMakeTranslation(0, 0, i*5);
    }
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = [[rectArr objectAtIndex:i] CGRectValue];
        [UIView animateWithDuration:(totalTime/cells.count) * i animations:^{
            cell.frame = rect;
        } completion:^(BOOL finished) {
            cell.layer.transform = CATransform3DIdentity;
        }];
    }
}

+ (void)roteAnimationWithTableView:(UITableView *)tableView {
    
    NSArray *cells = tableView.visibleCells;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(-M_PI);
    animation.toValue = 0;
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.alpha = 0.0;
        [UIView animateWithDuration:0.1 delay:i*0.25 options:0 animations:^{
            cell.alpha = 1.0;
        } completion:^(BOOL finished) {
            [cell.layer addAnimation:animation forKey:@"rotationYkey"];
        }];
    }
}
+ (void)fadeAnimationWithTableView:(UITableView *)tableView {
    
    NSArray<UITableViewCell *> *visibleCells = tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.alpha = 0.0;
        NSTimeInterval delay = idx * 0.1;
        [UIView animateWithDuration:0.25 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }];
}

+ (void)flipAnimationWithTableView:(UITableView *)tableView {
    NSArray<UITableViewCell *> *visibleCells = tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.layer.opacity = 0.0;
        cell.layer.transform = idx % 2 ? CATransform3DMakeRotation(M_PI, 1, 0, 0) : CATransform3DMakeRotation(M_PI, 0, 1, 0);
        NSTimeInterval delay = idx * (0.4 / visibleCells.count);
        [UIView animateWithDuration:0.55 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

+ (void)balloonAnimationWithTableView:(UITableView *)tableView {
    
    NSArray<UITableViewCell *> *visibleCells = tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.layer.opacity = 0.0;
        cell.transform = CGAffineTransformMakeScale(0.0, 0.0);
        
        NSTimeInterval delay = 0;
        delay = idx * (0.4 / visibleCells.count);
        //delay = (visibleCells.count - idx) * (0.4 / visibleCells.count);
        
        BOOL isUsingSpring = YES;
        
        if (isUsingSpring) {
            [UIView animateWithDuration:0.75 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.layer.opacity = 1.0;
                cell.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        } else {
            [UIView animateWithDuration:0.45 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.layer.opacity = 1.0;
                cell.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
}











@end
