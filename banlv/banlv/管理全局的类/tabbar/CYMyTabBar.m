//
//  CYMyTabBar.m
//  SinaBlog
//
//  Created by lcy on 16/4/17.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CYMyTabBar.h"


@interface CYMyTabBar ()

@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UIImageView *btnBgView;
@property(nonatomic,strong) UILabel *searchLab;


@end



@implementation CYMyTabBar


-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar_bgd"];

        self.searchView = [[UIView alloc] init];
        
        self.btnBgView = [[UIImageView alloc] init];
        self.btnBgView.image = [UIImage imageNamed:@"tabbar_bgd"];
        
        self.searchLab = [[UILabel alloc] init];
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
        
        [self.searchView addSubview:self.btnBgView];
        [self.searchView addSubview:self.searchBtn];
        [self.searchView addSubview:self.searchLab];
        [self addSubview:self.searchView];
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat space = self.width/5;
    
    self.searchView.frame = CGRectMake(space * 2, -10, space, TabBarH + 10);
    
    self.btnBgView.frame = CGRectMake((self.searchView.width - 45)/2, 0, 45, 45);
    self.btnBgView.layer.cornerRadius = 22.5f;
    self.btnBgView.layer.masksToBounds = YES;
    
    self.searchBtn.frame = CGRectMake((self.searchView.width - 40)/2, 2.5f, 40, 40);
    self.searchBtn.adjustsImageWhenHighlighted = NO;
    self.searchBtn.layer.cornerRadius = 20.f;
    self.searchBtn.layer.masksToBounds = YES;
    
    self.searchLab.frame = CGRectMake(0, TabBarH - 3, self.searchView.width, 10);
    self.searchLab.text = @"搜索";
    self.searchLab.textAlignment = NSTextAlignmentCenter;
    self.searchLab.textColor = [UIColor grayColor];
    self.searchLab.font = [UIFont systemFontOfSize:10.f];
    
    
    
}

@end
