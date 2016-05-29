//
//  CYBaomingViewController.m
//  banlv
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 llz. All rights reserved.
//

# define sixinH 50.f
#import "CYBaomingViewController.h"
#import "CYBaomingView.h"

@interface CYBaomingViewController ()

@end

@implementation CYBaomingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.myData.address);
    
    UIButton *Btn = [[UIButton alloc] init];
    Btn.frame = CGRectMake(0, kScreenFrameH - sixinH, kScreenFrameW, sixinH);
    Btn.backgroundColor = ThemeColor;
    [Btn setTitle:@"私信" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:Btn];

}



@end
