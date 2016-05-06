//
//  CYMyTabBar.m
//  SinaBlog
//
//  Created by lcy on 16/4/17.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CYMyTabBar.h"

#import "UIView+frame.h"

//#import "CYMyNavController.h"


#import "SearchViewController.h"

@interface CYMyTabBar ()


@property (nonatomic,strong)UIButton *searchBtn;


@end



@implementation CYMyTabBar


-(instancetype)init{
    self = [super init];
    if (self) {
        
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        UIImage *image = [UIImage imageNamed:@"tabbar_profile_n~iphone"];
        
        
        
        [searchBtn setImage:image forState:UIControlStateNormal];
        
        [searchBtn setImage:[UIImage imageNamed:@"tabbar_profile_s~iphone"] forState:UIControlStateSelected];
        
        searchBtn.frame = CGRectMake(0, - 20, image.size.width, image.size.height);
        [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:searchBtn];
        
        self.searchBtn = searchBtn;
        
    }
    return self;
}

- (void)searchClick:(id)sender{
    SearchViewController *new = [[SearchViewController alloc] init];
    
  
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:new];
    
    
    
    [window.rootViewController presentViewController:nav animated:NO completion:nil];

    

    
   
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.searchBtn.center = (CGPoint){self.width/2,self.height/2};
    
    CGFloat space = self.width/5;
    
    CGFloat centerY = self.height/2;
    
    
    int index = 0;
    
    for (UIView *aView in self.subviews) {
        if ([aView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (index == 2) {
                index ++;
            }
            
            aView.center = CGPointMake(space/2 + index * space,centerY);
            
            
            index ++;
            
        }
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
