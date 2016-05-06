//
//  UIView+GroupAnimation.h
//  百思
//
//  Created by lcy on 16/4/2.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GroupAnimation)

- (void)animationWithDuration:(NSTimeInterval)duration
                 propertyName:(NSString *)propertyName
                startLocation:(id)startValue
                 stopLocation:(id)stopValue
                  tingleSpace:(float)space;

@end
