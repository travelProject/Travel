//
//  CYViewPageImgView.h
//  LCViewPager
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 licong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CYViewPagerImgViewDelegate <NSObject>
/**
 *  监听图片点击响应方法
 */
- (void)didImageViewClick;

@end

@interface CYViewPageImgView : UIImageView


@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) id <CYViewPagerImgViewDelegate> delegate;


@end
