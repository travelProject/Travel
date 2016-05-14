//
//  FindViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//
#define  r  50.f
#define kSegmentH 30

#define kTableViewY 64

#import "FindViewController.h"

#import "CYXuanfuView.h"

#import "CYDizhuTableView.h"
#import "CYPartyTableView.h"

@interface FindViewController ()<UIScrollViewDelegate>

@property(nonatomic , assign)BOOL dizhuTagNum;
@property(nonatomic , assign)BOOL partyTagNum;

@property(nonatomic,strong)UISegmentedControl *seg;

@property(nonatomic, strong)UIScrollView *mainScrollView;

@property(nonatomic, strong)CYDizhuTableView *dizhuTableView;
@property(nonatomic, strong)CYPartyTableView *partyTableView;

@property(nonatomic, strong)UIButton *dizhuBtn;
@property(nonatomic, strong)CYXuanfuView *duzhiXuanfu;

@property(nonatomic, strong)UIButton *partyBtn;
@property(nonatomic, strong)CYXuanfuView *partyXuanfu;

@property(nonatomic, strong)UIImage *xuanfuImg;

@end

@implementation FindViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dizhuTagNum = NO;
    self.dizhuTagNum = NO;
    
    UIImage *xuanfuImg = [UIImage imageNamed:@"xuanfuButton"];
    
    self.xuanfuImg = xuanfuImg;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self creatSegment];
    
    [self creatScrollView];
    
    [self creatDizhuTableView];
    
    [self creaPartyTableView];
    
    
    [self setDizhuBtn];
    
    [self setPartyBtn];

    
    NSString *search = nil;
    
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"key\":\"%@\",\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\"\n}",search];
    
    NSString *urlStr = @"http://www.shafalvxing.com/channel/getLocalServiceList.do?";
//http://www.shafalvxing.com/channel/getLocalServiceList.do
//    bizParams：{
//          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2",
//          "page" : 1
//    }

    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        NSArray *jsonArr = [responseObject objectForKey:@"data"];
        NSLog(@"%@",jsonArr);
        
//        self.searchedCityArr = [FYSingleCityData mj_objectArrayWithKeyValuesArray:jsonArr];
//        
//        //刷新搜索表格
//        [self.searchedTableView reloadData];
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];

    
    
    
    
}

- (void)setPartyBtn{
    
    UIButton *partyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrameW*1/7+kScreenFrameW, kScreenFrameH*7/10, r, r)];
    
    
    
    
    [partyBtn setImage:self.xuanfuImg forState:UIControlStateNormal];
    
    
    partyBtn.layer.masksToBounds = YES;
    partyBtn.layer.cornerRadius = r/2;
    
    [self.mainScrollView addSubview:partyBtn];
    [self.mainScrollView bringSubviewToFront:partyBtn];
    
    [partyBtn addTarget:self action:@selector(partyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.partyBtn = partyBtn;
    
    CYXuanfuView *partyXuanfu = [[CYXuanfuView alloc] init];
    
    partyXuanfu = kLoadViewWithNIB(@"CYXuanfuView");
    
    
    
    partyXuanfu.frame = CGRectMake(kScreenFrameW*1/7+r/2+kScreenFrameW, kScreenFrameH*7/10+4, 0, partyBtn.size.height-8);
    
    [partyXuanfu.leftButton setTitle:@"     我预约的" forState:UIControlStateNormal];
    
    [partyXuanfu.rightButton setTitle:@"我要做地主" forState:UIControlStateNormal];
    
    [partyXuanfu.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [partyXuanfu.rightButton addTarget:self action:@selector(rightButtonAction:)   forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.mainScrollView addSubview:partyXuanfu];
    self.partyXuanfu = partyXuanfu;
}



- (void)setDizhuBtn{
    
        UIButton *dizhuBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrameW*1/7, kScreenFrameH*7/10, r, r)];
        
        
    
    
        [dizhuBtn setImage:self.xuanfuImg forState:UIControlStateNormal];
        
        
        dizhuBtn.layer.masksToBounds = YES;
        dizhuBtn.layer.cornerRadius = r/2;
    
        [self.mainScrollView addSubview:dizhuBtn];
        [self.mainScrollView bringSubviewToFront:dizhuBtn];
        
        [dizhuBtn addTarget:self action:@selector(dizhuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dizhuBtn = dizhuBtn;
        
        CYXuanfuView *duzhiXuanfu = [[CYXuanfuView alloc] init];
        
        duzhiXuanfu = kLoadViewWithNIB(@"CYXuanfuView");
        
        
        
        duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+r/2, kScreenFrameH*7/10+4, 0, dizhuBtn.size.height-8);
        
        [duzhiXuanfu.leftButton setTitle:@"     我预约的" forState:UIControlStateNormal];
        
        [duzhiXuanfu.rightButton setTitle:@"我要做地主" forState:UIControlStateNormal];
        
        [duzhiXuanfu.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [duzhiXuanfu.rightButton addTarget:self action:@selector(rightButtonAction:)   forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.mainScrollView addSubview:duzhiXuanfu];
        self.duzhiXuanfu = duzhiXuanfu;
    
}



- (void)rightButtonAction:(id)sender{
    NSLog(@"rrrr");
}
- (void)leftButtonAction:(id)sender{
    NSLog(@"lll");
}
- (void)partyBtnAction:(id)sender{
    
    
    if (self.partyTagNum == NO) {
        
        
        [UIView animateWithDuration:0.6 animations:^{
            
            
            self.partyXuanfu.frame = CGRectMake(kScreenFrameW+kScreenFrameW*1/7+r/2, kScreenFrameH*7/10+4, 200, self.partyBtn.size.height-8);
            [self.mainScrollView bringSubviewToFront:self.partyBtn];
            
        }];
        
        self.partyTagNum =YES;
        
        
    }else{
        self.partyXuanfu.frame = CGRectMake(kScreenFrameW+kScreenFrameW*1/7+r/2, kScreenFrameH*7/10+4, 0, self.partyBtn.size.height-8);
        
        self.partyTagNum=NO;
    }

    
}
- (void)dizhuBtnAction:(id)sender{
    
    if (self.dizhuTagNum == NO) {
    
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+r/2, kScreenFrameH*7/10+4, 200, self.dizhuBtn.size.height-8);
        [self.mainScrollView bringSubviewToFront:self.dizhuBtn];

    }];
        
        self.dizhuTagNum =YES;
        
        
    }else{
        self.duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+r/2, kScreenFrameH*7/10+4, 0, self.dizhuBtn.size.height-8);
     
        self.dizhuTagNum=NO;
    }
    
    
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


@end
