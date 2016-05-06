//
//  UIView+frame.h
//  百思
//
//  Created by lcy on 16/3/19.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于UIView的布局
@interface UIView (frame)

@property (nonatomic,assign)CGFloat x,y,width,height;

@property (nonatomic,assign)CGPoint origin;

@property (nonatomic,assign)CGPoint center;

@property (nonatomic,assign)CGSize size;

@end
