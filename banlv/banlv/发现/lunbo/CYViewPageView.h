//
//  CYViewPageView.h
//  LCViewPager
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 lcy. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CYViewPagerDelegate <NSObject>

/**
 *  点击ViewPagerView触发的方法
 *
 *  @param tag 点击的第几张图片
 */
- (void)didViewPagerViewClick:(NSInteger)tag;

@end


@interface CYViewPageView : UIView

@property (nonatomic, strong) NSArray *imageAry;
@property (nonatomic, assign) id <CYViewPagerDelegate> delegate;


@end
