//
//  FYCollectionFooter.m
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCollectionFooter.h"

@implementation FYCollectionFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //不要忘记初始化（坑爹啊，xib习惯了）
        self.footImgView = [[UIImageView alloc] init];
        self.moreCity = [[UIButton alloc] init];
        self.moreCity.frame = CGRectMake(kScreenFrameW / 2 - 60, 0.4526f * kScreenFrameW / 2 - 10, 120, 20);
        
        [self.moreCity setBackgroundColor:[UIColor blackColor]];
        
        self.moreCity.layer.cornerRadius = 10.f;
        self.moreCity.layer.masksToBounds = YES;
        
        [self.moreCity setTitle:@"查看更多城市" forState:UIControlStateNormal];
        [self.moreCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.moreCity.titleLabel.font = [UIFont systemFontOfSize:12.f];
        
        self.moreCity.alpha = 0.7;
        
        [self addSubview:self.footImgView];
        [self addSubview:self.moreCity];
        
    }
    return self;
}

- (void)setFooterPic:(NSString *)footerPic
{
    _footerPic = footerPic;
    
    [self.footImgView sd_setImageWithURL:[NSURL URLWithString:_footerPic] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.footImgView.frame = CGRectMake(0, 0, kScreenFrameW, 0.4526f * kScreenFrameW);
    
}

@end
