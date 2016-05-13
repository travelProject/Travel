//
//  FindViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#define kSegmentH 30

#define kTableViewY 64

#import "FindViewController.h"

#import "CYXuanfuView.h"

#import "CYDizhuTableView.h"
#import "CYPartyTableView.h"

@interface FindViewController ()<UIScrollViewDelegate>



@property(nonatomic,strong)UISegmentedControl *seg;

@property(nonatomic, strong)UIScrollView *mainScrollView;

@property(nonatomic, strong)CYDizhuTableView *dizhuTableView;
@property(nonatomic, strong)CYPartyTableView *partyTableView;

@property(nonatomic, strong)UIButton *btn;

@end

@implementation FindViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self creatSegment];
    
    [self creatScrollView];
    
    [self creatDizhuTableView];
    
    [self creaPartyTableView];
    
    CGFloat r = 50.f;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrameW*1/7, kScreenFrameH*7/10, r, r)];
    
    
    btn.backgroundColor = [UIColor whiteColor];
    
    [btn setImage:[UIImage imageNamed:@"xuanfuButton"] forState:UIControlStateNormal];
    
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = r/2;
    
    [self.mainScrollView addSubview:btn];
    [self.mainScrollView bringSubviewToFront:btn];
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn = btn;
    
    
    CYXuanfuView *xunfu = [[CYXuanfuView alloc] init];
    
    xunfu = kLoadViewWithNIB(@"CYXuanfuView");
    
    xunfu.backgroundColor = [UIColor whiteColor];
    
    xunfu.frame = CGRectMake(kScreenFrameW*1/7+r, kScreenFrameH*7/10, 200, r);
    
    [xunfu.leftButton setTitle:@"我预约的" forState:UIControlStateNormal];
    
    [xunfu.rightButton setTitle:@"我要做地主" forState:UIControlStateNormal];
    
    [xunfu.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [xunfu.rightButton addTarget:self action:@selector(rightButtonAction:)   forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.mainScrollView addSubview:xunfu];
    
    
    
    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager GET:@"http://www.shafalvxing.com/channel/getLocalServiceList.do" parameters:@{@"userToken":@"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2" ,@"page":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = [[responseObject objectForKey:@"rtnStatus"]   objectForKey:@"message"];
//        
//        NSLog(@"eee%@",dict);
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"error : %@",error);
//    }];
//    
    
    
}
- (void)rightButtonAction:(id)sender{
    NSLog(@"rrrr");
}
- (void)leftButtonAction:(id)sender{
    NSLog(@"lll");
}

- (void)btnAction:(id)sender{
    NSLog(@"*****");
    [UIView animateWithDuration:0.6 animations:^{
        
    }];
    
}

//contentOffset:滑动视图里面的内容的相对位置
//contentInset:滑动视图在外面的相对位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x/kScreenFrameW + 0.5;
    
    self.seg.selectedSegmentIndex = pageNum;
    
    
}

- (void)creatScrollView{
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH)];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW *2, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY );
    
//    mainScrollView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:mainScrollView];
    
}

- (void)creatSegment{
    
    NSArray *arrItems = @[@"叫地主",@"聚会&派对"];
    
  
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arrItems];
    seg.size = CGSizeMake(50, 10);
    seg.center = CGPointMake(kScreenFrameW/2, 44/2);
    seg.backgroundColor = [UIColor whiteColor];
    
  
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
   
    
    
    
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    
    self.seg = seg;
    
    
    

    
}

- (void)segAction:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.mainScrollView.contentOffset = CGPointMake(kScreenFrameW * self.seg.selectedSegmentIndex, - 64);
        
        
    }];
    
    
    
    
    
}


- (void)creatDizhuTableView{
    
    CYDizhuTableView *dizhuTableView = [[CYDizhuTableView alloc] init];
    
    dizhuTableView.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY );
    [self.mainScrollView addSubview:dizhuTableView];
    
    

    
    self.dizhuTableView = dizhuTableView;
    

    

    
}


- (void)creaPartyTableView{
    
    CYPartyTableView *partyTableView = [[CYPartyTableView alloc] init];
    partyTableView.frame = CGRectMake(kScreenFrameW, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY );
    
    partyTableView.backgroundColor = [UIColor yellowColor];
    
    [self.mainScrollView addSubview:partyTableView];
    
    self.partyTableView = partyTableView;
    
    


    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
