//
//  CYPoViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//
# define poBtnH 50.f
# define jiange 20.f

#import "CYPoViewController.h"
#import "CYPoHeaderView.h"

@interface CYPoViewController ()<UIScrollViewDelegate>

@end

@implementation CYPoViewController

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
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.title = @"发布";
   
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - 64, kScreenFrameW, kScreenFrameH - poBtnH)];
    mainScrollView.showsHorizontalScrollIndicator = NO;
//    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
//    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,4*jiange+44*6+400  );
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    
    
    
    CYPoHeaderView *CYHeader = [[CYPoHeaderView alloc] init];
    
    CYHeader.frame = CGRectMake(0, 0, kScreenFrameW, 400);
    
    [mainScrollView addSubview:CYHeader];
    
    UIButton *poBtn = [[UIButton alloc] init];
    poBtn.frame = CGRectMake(0, kScreenFrameH - poBtnH, kScreenFrameW, poBtnH);
    poBtn.backgroundColor = ThemeColor;
    [poBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.view addSubview:poBtn];
    
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, CYHeader.size.height + jiange, kScreenFrameW, 44);
    UILabel *left = [[UILabel alloc] init];
    
    left.center = CGPointMake(4, view1.size.height /2);
    left.size = CGSizeMake(100, 38);
    left.text = @"开始时间";
    left.backgroundColor = [UIColor redColor];
    
    
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    [view1 addSubview:left];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(0, view1.origin.y + 44 , kScreenFrameW, 44);
    view2.backgroundColor = [UIColor greenColor];
    [mainScrollView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(0, view2.origin.y + 44 +jiange , kScreenFrameW, 44);
    view3.backgroundColor = [UIColor greenColor];
    [mainScrollView addSubview:view3];
    
    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(0, view3.origin.y + 44 , kScreenFrameW, 44);
    view4.backgroundColor = [UIColor redColor];
    [mainScrollView addSubview:view4];
    
    
    UIView *view5 = [[UIView alloc] init];
    view5.frame = CGRectMake(0, view4.origin.y + 44 +jiange , kScreenFrameW, 44);
    view5.backgroundColor = [UIColor greenColor];
    [mainScrollView addSubview:view5];
    
    UIView *view6 = [[UIView alloc] init];
    view6.frame = CGRectMake(0, view5.origin.y + 44 +jiange , kScreenFrameW, 44);
    view6.backgroundColor = [UIColor greenColor];
    [mainScrollView addSubview:view6];
    

    

}
@end
