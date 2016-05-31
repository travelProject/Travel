//
//  CYDoDiViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//
# define poBtnH 50.f
# define jiange 20.f

#import "CYDoDiViewController.h"
#import "CYDoDizhuView.h"

@interface CYDoDiViewController ()<UIScrollViewDelegate>

@end

@implementation CYDoDiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"我要做地主";
    
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - 64, kScreenFrameW, kScreenFrameH - poBtnH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;

    mainScrollView.delegate = self;
    
   
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,748.000000 );
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    CYDoDizhuView *header = [[CYDoDizhuView alloc] init];
   header.frame = CGRectMake(0, 0, kScreenFrameW, 380);
    [mainScrollView addSubview:header];
    
    UIButton *poBtn = [[UIButton alloc] init];
    poBtn.frame = CGRectMake(0, kScreenFrameH - poBtnH, kScreenFrameW, poBtnH);
    poBtn.backgroundColor = ThemeColor;
    [poBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.view addSubview:poBtn];
    
    
    
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, header.size.height + jiange, kScreenFrameW, 44);
    
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    
    UILabel *left1 = [[UILabel alloc] init];
    
    left1.frame = CGRectMake((kScreenFrameW - 150)/2, 3, 150, 38);
    left1.textAlignment = NSTextAlignmentCenter;
    left1.text = @"城市和价格";
    
    [view1 addSubview:left1];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(0, view1.origin.y + 44 , kScreenFrameW, 44);
    view2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view2];
    UILabel *left2 = [[UILabel alloc] init];
    
    left2.frame = CGRectMake(8, 3, 80, 38);
    
    left2.text = @"城市";
    
    [view2 addSubview:left2];
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.frame = CGRectMake(kScreenFrameW - 58, 3, 50, 38);
    
    [btn2 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn2 setTitle:@"选择" forState:UIControlStateNormal];
    [view2 addSubview:btn2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(0, view2.origin.y + 44  , kScreenFrameW, 44);
    view3.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view3];
    UILabel *left3 = [[UILabel alloc] init];
    
    left3.frame = CGRectMake(8, 3, 80, 38);
    
    left3.text = @"价格";
    
    [view3 addSubview:left3];
    UIButton *btn3 = [[UIButton alloc] init];
    btn3.frame = CGRectMake(kScreenFrameW - 58, 3, 50, 38);
    
    [btn3 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn3 setTitle:@"选择" forState:UIControlStateNormal];
    [view3 addSubview:btn3];
    
    
    
    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(0, view3.origin.y + 44 +jiange, kScreenFrameW, 44);
    view4.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view4];
    UILabel *left4 = [[UILabel alloc] init];
    
    left4.frame = CGRectMake((kScreenFrameW - 150)/2, 3, 150, 38);
    
    left4.text = @"可提供的服务";
    left4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:left4];
   
    
    
    UIView *view5 = [[UIView alloc] init];
    view5.frame = CGRectMake(0, view4.origin.y + 44 , kScreenFrameW, 44);
    view5.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view5];
    UILabel *left5 = [[UILabel alloc] init];
    
    left5.frame = CGRectMake(8, 3, 80, 38);
    
    left5.text = @"跟拍";
    
    [view5 addSubview:left5];
    UISwitch *swc5 = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenFrameW - 60, 3, 60, 38)];
    [swc5 setOnTintColor:ThemeColor];
    
    swc5.tintColor = ThemeColor ;
    [view5 addSubview:swc5];
    
    
    
    UIView *view6 = [[UIView alloc] init];
    view6.frame = CGRectMake(0, view5.origin.y + 44 , kScreenFrameW, 44);
    view6.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view6];
    UILabel *left6 = [[UILabel alloc] init];
    
    left6.frame = CGRectMake(8, 3, 80, 38);
    
    left6.text = @"伴游";
    
    [view6 addSubview:left6];
    UISwitch *swc6 = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenFrameW - 60, 3, 60, 38)];
    [swc6 setOnTintColor:ThemeColor];
    
    swc6.tintColor = ThemeColor ;
    [view6 addSubview:swc6];
    
    
    
    UIView *view7 = [[UIView alloc] init];
    view7.frame = CGRectMake(0, view6.origin.y + 44 +jiange , kScreenFrameW, 44);
    view7.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view7];
    UILabel *left7 = [[UILabel alloc] init];
    
    left7.frame = CGRectMake(8, 3, 80, 38);
    
    left7.text = @"实名认证";
    
    [view7 addSubview:left7];
    UIButton *btn7 = [[UIButton alloc] init];
    btn7.frame = CGRectMake(kScreenFrameW - 88, 3, 80, 38);
    
    [btn7 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn7 setTitle:@"立即认证" forState:UIControlStateNormal];
    [view7 addSubview:btn7];
  
    
    
    

    
}

@end
