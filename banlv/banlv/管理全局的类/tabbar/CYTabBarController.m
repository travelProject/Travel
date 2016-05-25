//
//  CYTabBarController.m
//  SinaBlog
//
//  Created by lcy on 16/4/17.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CYTabBarController.h"

#import "HomeViewController.h"
#import "FindViewController.h"
#import "SearchViewController.h"
#import "BLOrdersViewController.h"
#import "BLTempController.h"

#import "CYMyTabBar.h"

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
    
    [self addViewController:[[SearchViewController alloc]init] withImage:nil withSelectImage:nil withItemTitle:@"搜索"];
    
    [self addViewController:[[BLOrdersViewController alloc]init] withImage:@"dingdan" withSelectImage:@"dingdan_click" withItemTitle:@"订单"];
    
    [self addViewController:[[BLTempController alloc]init] withImage:@"wode" withSelectImage:@"wode_click" withItemTitle:@"我的"];
    
    [self setValue:[[CYMyTabBar alloc] init] forKey:@"tabBar"];
    
    
}


- (void)addViewController:(UIViewController *)vc withImage:(NSString *)imageName withSelectImage:(NSString *)selectImageName withItemTitle:(NSString *)title{
    
    vc.tabBarItem.title = title;
    
    if (imageName && selectImageName) {
        
        vc.tabBarItem.image = [UIImage imageNamed:imageName];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    BLNavigationController *nav = [[BLNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
