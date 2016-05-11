//
//  CYMyTabBar.m
//  SinaBlog
//
//  Created by lcy on 16/4/17.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CYMyTabBar.h"

#import "UIView+frame.h"

#import "SearchViewController.h"

@interface CYMyTabBar ()

@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UIView *btnBgView;
@property (nonatomic,strong) UIButton *searchBtn;
@property(nonatomic,strong) UILabel *searchLab;


@end



@implementation CYMyTabBar


-(instancetype)init{
    self = [super init];
    if (self) {

        self.searchView = [[UIView alloc] init];
        
        self.btnBgView = [[UIView alloc] init];
        
        self.searchLab = [[UILabel alloc] init];
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
        
        [self.searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.searchView addSubview:self.btnBgView];
        [self.searchView addSubview:self.searchBtn];
        [self.searchView addSubview:self.searchLab];
        [self insertSubview:self.searchView atIndex:100];
        
    }
    return self;
}

- (void)searchClick:(id)sender{
    
//    SearchViewController *new = [[SearchViewController alloc] init];
    
  
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:new];

//    
//    [window.rootViewController presentViewController:nav animated:NO completion:nil];

    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat space = self.width/5;
    
    CGFloat centerY = self.height/2;
    
    
    self.searchView.frame = CGRectMake(space * 2, -10, space, TabBarH + 10);
    
    self.btnBgView.frame = CGRectMake((self.searchView.width - 45)/2, 0, 45, 45);
    self.btnBgView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
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
    
    int index = 0;
    
    for (UIView *aView in self.subviews) {
        
        if ([aView isKindOfClass:[UIImageView class]] && aView.bounds.size.height <= 1) {
            aView.hidden = YES;
        }
        
        if ([aView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (index == 2) {
                index ++;
            }
            
            aView.center = CGPointMake(space/2 + index * space,centerY);
            
            index ++;
            
        }
    }
    
    
}

@end
