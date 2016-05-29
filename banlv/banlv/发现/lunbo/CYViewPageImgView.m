//
//  CYViewPageImgView.m
//  LCViewPager
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import "CYViewPageImgView.h"


@interface CYViewPageImgView ()<UIGestureRecognizerDelegate>

@end
@implementation CYViewPageImgView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //添加图片点击方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        //单击点击有效
        tap.numberOfTapsRequired = 1;
        //1个手指点击有效
        tap.numberOfTouchesRequired = 1;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}
/**
 *  通过在该方法内改变加载图片的方法
 *
 *  @param imageName 图片名,也是可以是网络图片地址，网络图片加载自行修改该方法
 */
- (void)setImageName:(NSString *)imageName
{
    
    _imageName = imageName;
   
//    
    NSURL *url = [NSURL URLWithString:imageName ];
    
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"angle-mask"]];
    
//    self.image = [UIImage imageNamed:imageName];
    
    
}

//点击手势
- (void)tap
{
    if ([self.delegate respondsToSelector:@selector(didImageViewClick)]) {
        [self.delegate didImageViewClick];
    }
}



@end
