//
//  UIView+GroupAnimation.m
//  百思
//
//  Created by lcy on 16/4/2.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIView+GroupAnimation.h"

@implementation UIView (GroupAnimation)

/**
 *  View动画
 *
 *  @param duration     每次动画事件间隔
 *  @param propertyName 动画的属性
 *  @param startValue   开始位置
 *  @param stopValue    结束位置
 *  @param space        颤抖的幅度
 */
- (void)animationWithDuration:(NSTimeInterval)duration
                 propertyName:(NSString *)propertyName
                startLocation:(id)startValue
                 stopLocation:(id)stopValue
                  tingleSpace:(float)space
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    
    basicAnimation.removedOnCompletion = NO ;
    
    basicAnimation.fillMode = kCAFillModeForwards;
    
    basicAnimation.duration = duration;
    
    basicAnimation.fromValue = startValue;
    
    basicAnimation.byValue = stopValue;
    
    [self.layer addAnimation:basicAnimation forKey:propertyName];
    
    
    
}



@end
