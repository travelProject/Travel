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
    
    [self addViewController:[[HomeViewController alloc]init] withImage:@"shouye" withSelectImage:@"shouye_click" withItemTitle:@"首页"];
    
    [self addViewController:[[FindViewController alloc]init] withImage:@"faxian" withSelectImage:@"faxian_click" withItemTitle:@"发现"];
    
    [self addViewController:[[OrderViewController alloc]init] withImage:@"dingdan" withSelectImage:@"dingdan_click" withItemTitle:@"订单"];
    
    [self addViewController:[[MainViewController alloc]init] withImage:@"wode" withSelectImage:@"wode_click" withItemTitle:@"我的"];
    
    CYMyTabBar *newTabBar = [[CYMyTabBar alloc] init];
    
    [newTabBar.searchBtn addTarget:self action:@selector(showSearchVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self setValue:newTabBar forKey:@"tabBar"];
    
    
    
    
}


- (void)addViewController:(UIViewController *)vc withImage:(NSString *)imageName withSelectImage:(NSString *)selectImageName withItemTitle:(NSString *)title{
    
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
 
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}

- (void)showSearchVC{
    
//    SearchViewController *new = [[SearchViewController alloc] init];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:new];
//    
//    [self setSelectedViewController:nav];
    
    SearchViewController *new = [[SearchViewController alloc] init];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:new];
    
    [window.rootViewController presentViewController:nav animated:NO completion:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
