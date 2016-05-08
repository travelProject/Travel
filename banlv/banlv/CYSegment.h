//
//  CYSegment.h
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CYSegmentDirectionLeft,
    CYSegmentDirectionRight,
} CYSegmentDirection;

typedef void(^CYChangeDirectioBlock)(CYSegmentDirection direction);


@interface CYSegment : UIControl
//每个标签宽度
@property(nonatomic, assign)CGFloat perWidth;

//标签数组
@property(nonatomic, strong)NSArray *items;

//自身背景颜色
@property(nonatomic, strong)UIColor *segmentBgColor;

//选中每块标签的字体颜色
@property(nonatomic, strong)UIColor *perColor;

//默认每块标签的字体颜色
@property(nonatomic, strong)UIColor *defaultPerColor;

//下划线的背景颜色
@property(nonatomic, strong)UIColor *underLayerBackgroudColor;

//标签选中索引
@property(nonatomic, assign)NSInteger selectIdx;

//上次选中的标签索引
@property(nonatomic, assign)NSInteger lastSelectIdx;

//下划线
@property(nonatomic, strong)CALayer *underLayer;



//当点击不同标签的时候，回调的block，让相关显示控件左响应的动画
@property(nonatomic, copy)CYChangeDirectioBlock changeDirection;

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items;


@end
