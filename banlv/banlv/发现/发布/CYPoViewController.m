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
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    self.title = @"发布";
   
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - 64, kScreenFrameW, kScreenFrameH - poBtnH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
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
    
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    
    UILabel *left1 = [[UILabel alloc] init];
    
    left1.frame = CGRectMake(8, 3, 80, 38);
    
    left1.text = @"开始时间";
    
    [view1 addSubview:left1];
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.frame = CGRectMake(kScreenFrameW - 68, 3, 60, 38);
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"请设置" forState:UIControlStateNormal];
    [view1 addSubview:btn1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(0, view1.origin.y + 44 , kScreenFrameW, 44);
    view2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view2];
    UILabel *left2 = [[UILabel alloc] init];
    
    left2.frame = CGRectMake(8, 3, 80, 38);
    
    left2.text = @"结束时间";
    
    [view2 addSubview:left2];
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.frame = CGRectMake(kScreenFrameW - 68, 3, 60, 38);
    
    [btn2 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn2 setTitle:@"请设置" forState:UIControlStateNormal];
    [view2 addSubview:btn2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(0, view2.origin.y + 44 +jiange , kScreenFrameW, 44);
    view3.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view3];
    UILabel *left3 = [[UILabel alloc] init];
    
    left3.frame = CGRectMake(8, 3, 80, 38);
    
    left3.text = @"活动价格";
    
    [view3 addSubview:left3];
    UITextField *tf3 = [[UITextField alloc] init];
    tf3.frame = CGRectMake(kScreenFrameW - 100, 3, 100, 38);
    tf3.placeholder = @"请输入价格";
    [view3 addSubview:tf3];

    
    
    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(0, view3.origin.y + 44 , kScreenFrameW, 44);
    view4.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view4];
    UILabel *left4 = [[UILabel alloc] init];
    
    left4.frame = CGRectMake(8, 3, 80, 38);
    
    left4.text = @"人数限制";
    
    [view4 addSubview:left4];
    UITextField *tf4 = [[UITextField alloc] init];
    tf4.frame = CGRectMake(kScreenFrameW - 120, 3, 120, 38);
    tf4.placeholder = @"请输入最高人数";
    [view4 addSubview:tf4];
    
    
    UIView *view5 = [[UIView alloc] init];
    view5.frame = CGRectMake(0, view4.origin.y + 44 +jiange , kScreenFrameW, 44);
    view5.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view5];
    UILabel *left5 = [[UILabel alloc] init];
    
    left5.frame = CGRectMake(8, 3, 80, 38);
    
    left5.text = @"活动地址";
    
    [view5 addSubview:left5];
    UIButton *btn5 = [[UIButton alloc] init];
    btn5.frame = CGRectMake(kScreenFrameW - 58, 3, 50, 38);
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn5 setTitle:@"设置" forState:UIControlStateNormal];
    [view5 addSubview:btn5];

    
    
    UIView *view6 = [[UIView alloc] init];
    view6.frame = CGRectMake(0, view5.origin.y + 44 +jiange , kScreenFrameW, 44);
    view6.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view6];
    UILabel *left6 = [[UILabel alloc] init];
    
    left6.frame = CGRectMake(8, 3, 80, 38);
    
    left6.text = @"实名认证";
    
    [view6 addSubview:left6];
    UIButton *btn6 = [[UIButton alloc] init];
    btn6.frame = CGRectMake(kScreenFrameW - 88, 3, 80, 38);
    
    [btn6 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn6 setTitle:@"立即认证" forState:UIControlStateNormal];
    [view6 addSubview:btn6];

    

}
@end
