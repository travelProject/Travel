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
#import "CYSegment.h"


#import "CYDizhuTableView.h"
#import "CYPartyTableView.h"


#import "UIView+frame.h"

@interface FindViewController ()<UIScrollViewDelegate>


@property(nonatomic, strong)CYSegment *segment;
@property(nonatomic,strong)UISegmentedControl *seg;

@property(nonatomic, strong)UIScrollView *mainScrollView;

@property(nonatomic, strong)CYDizhuTableView *dizhuTableView;
@property(nonatomic, strong)CYPartyTableView *partyTableView;

@end

@implementation FindViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"发现"];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self creatSegment];
    
    [self creatScrollView];
    
    [self creatDizhuTableView];
    
    [self creaPartyTableView];
    
    
   
    
    
    
    
    
    
    
}
//contentOffset:滑动视图里面的内容的相对位置
//contentInset:滑动视图在外面的相对位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x/kScreenFrameW;
    self.segment.selectIdx =pageNum;
    self.seg.selectedSegmentIndex = pageNum;
}

- (void)creatScrollView{
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+ kSegmentH, kScreenFrameW, kScreenFrameH)];
//    mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW *2, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY - kSegmentH);
    
    mainScrollView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:mainScrollView];
    
}

- (void)creatSegment{
    
    NSArray *arrItems = @[@"叫地主",@"聚会"];
    
    CYSegment *segment = [[CYSegment alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 30) withItems:arrItems];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arrItems];
    seg.frame = CGRectMake(0, 64, kScreenFrameW, 30);
    seg.backgroundColor = [UIColor whiteColor];
    
    segment.segmentBgColor = [UIColor whiteColor];
    
    segment.defaultPerColor = [UIColor blackColor];
    
    segment.perColor = [UIColor redColor];
    
    segment.underLayerBackgroudColor = [UIColor redColor];
    
    segment.selectIdx = 0;
    
    
    seg.selectedSegmentIndex = 0;
    [self.view addSubview:seg];
    
    self.seg = seg;
    
    
    
//    [self.view addSubview:segment];
    
    self.segment = segment;

    
}


- (CYDizhuTableView *)creatDizhuTableView{
    
    CYDizhuTableView *dizhuTableView = [[CYDizhuTableView alloc] init];
    
    dizhuTableView.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY - kSegmentH);
    [self.mainScrollView addSubview:dizhuTableView];
    
    dizhuTableView.backgroundColor = [UIColor redColor];
    
    self.dizhuTableView = dizhuTableView;
    

    
    
    
    return dizhuTableView;
    
}


- (CYPartyTableView *)creaPartyTableView{
    
    CYPartyTableView *partyTableView = [[CYPartyTableView alloc] init];
    partyTableView.frame = CGRectMake(kScreenFrameW, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY - kSegmentH);
    
    [self.mainScrollView addSubview:partyTableView];
    
    self.partyTableView = partyTableView;
    
    
    
    
    
    return partyTableView;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
