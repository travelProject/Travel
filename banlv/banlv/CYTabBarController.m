//
//  CYTabBarController.m
//  SinaBlog
//
//  Created by lcy on 16/4/17.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CYTabBarController.h"

#import "CYMyTabBar.h"

#import "MainViewController.h"
#import "OrderViewController.h"
#import "SearchViewController.h"

#import "FindViewController.h"
#import "HomeViewController.h"

@interface CYTabBarController ()

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor brownColor]};
    
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    self.tabBarItem = item;
    
    [self addViewController:[[HomeViewController alloc]init] withImage:@"tabbar_profile_n~iphone" withSelectImage:@"tabbar_profile_s~iphone" withItemTitle:@"首页"];
    
    [self addViewController:[[FindViewController alloc]init] withImage:@"tabbar_profile_n~iphone" withSelectImage:@"tabbar_profile_s~iphone" withItemTitle:@"发现"];
    
    [self addViewController:[[SearchViewController alloc]init] withImage:@"tabbar_profile_n~iphone" withSelectImage:@"tabbar_profile_s~iphone"withItemTitle:@"搜索"];
    
    [self addViewController:[[OrderViewController alloc]init] withImage:@"tabbar_profile_n~iphone" withSelectImage:@"tabbar_profile_s~iphone" withItemTitle:@"订单"];
    
    [self addViewController:[[MainViewController alloc]init] withImage:@"tabbar_profile_n~iphone" withSelectImage:@"tabbar_profile_s~iphone" withItemTitle:@"我的"];
    
    [self setValue:[[CYMyTabBar alloc] init]  forKey:@"tabBar"];
    
    
    
}


- (void)addViewController:(UIViewController *)vc withImage:(NSString *)imageName withSelectImage:(NSString *)selectImageName withItemTitle:(NSString *)title{
    
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
 
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
