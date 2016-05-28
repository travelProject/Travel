//
//  CYDizCellChildViewController.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//
# define sixinH 50.f
#import "CYDizCellChildViewController.h"

#import "CYDView1.h"
#import "CYDView2.h"
#import "CYDView3.h"
#import "CYDView4.h"

@interface CYDizCellChildViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)CYDView1 *view1;
@property(nonatomic, strong)CYDView2 *view2;
@property(nonatomic, strong)CYDView3 *view3;
@property(nonatomic, strong)CYDView4 *view4;

@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong)UIScrollView *mainScrollView;

@end

@implementation CYDizCellChildViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.mainScrollView.contentOffset.y < 0) {
        
        self.barView.hidden = YES;
        
    }else if (self.mainScrollView.contentOffset.y < 280){
        
        self.barView.hidden = NO;
        self.barView.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f  alpha:self.mainScrollView.contentOffset.y / 500];
        
    }else{
        
        self.barView.hidden = NO;
        self.barView.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.barView = self.navigationController.navigationBar;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
    //    NSLog(@"%@",self.myData.title);
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViews];
    
    self.title = @"叫地主";
    
    self.view.backgroundColor = ThemeColor;
    [self request];
    
    UIButton *baomingBtn = [[UIButton alloc] init];
    baomingBtn.frame = CGRectMake(0, kScreenFrameH - sixinH, kScreenFrameW, sixinH);
    baomingBtn.backgroundColor = [UIColor colorWithRed:0.28 green:0.79 blue:0.78 alpha:1];
    [baomingBtn setTitle:@"报名" forState:UIControlStateNormal];
    [self.view addSubview:baomingBtn];
    
    
    
    self.view1.frame = CGRectMake(0, -44, kScreenFrameW, 366);
    self.view2.frame = CGRectMake(0, CGRectGetMaxY(self.view1.frame)+10, kScreenFrameW, 343);
    self.view3.frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame)+10, kScreenFrameW, 92);
    self.view4.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame)+10, kScreenFrameW, 134);
    
    
}

- (void)request{
    
//    三级页面：http://www.shafalvxing.com/channel/localServiceDetail.do
//    bizParams：{
//          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2",
//          "localServiceId" : 262
//    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    NSLog(@"%@".self.i);
    self.i = @"262";
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"localServiceId\":%@}",self.i];
    
    NSString *urlStr = @"http://www.shafalvxing.com/channel/localServiceDetail.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
//        NSArray *jsonArr =[responseObject objectForKey:@"data"];
        
//        CYParCellChildData *myData  = [CYParCellChildData  mj_objectWithKeyValues:jsonArr];
//        
//        self.myData = myData;
//        [self addIfo];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)setViews{
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, kScreenFrameW, kScreenFrameH - sixinH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    //    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
    //    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,4*50+44*6+400  +456);
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    
    
    CYDView1 *view1 = [[CYDView1 alloc] init];
    
    [mainScrollView addSubview:view1];
    self.view1 = view1;
    
    CYDView2 *view2 = [[CYDView2 alloc] init];
    
    [mainScrollView addSubview:view2];
    self.view2 = view2;
    
    CYDView3 *view3 = [[CYDView3 alloc] init];
    
    [mainScrollView addSubview:view3];
    self.view3 = view3;
    
    CYDView4 *view4 = [[CYDView4 alloc] init];
    
    [mainScrollView addSubview:view4];
    self.view4 = view4;

    
}


@end
