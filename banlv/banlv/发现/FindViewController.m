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

#import "CYJoinedViewController.h"
#import "CYDoDiViewController.h"
#import "CYPoViewController.h"


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
 
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    UIImage *xuanfuImg = [UIImage imageNamed:@"xuanfuButton"];
    
    self.xuanfuImg = xuanfuImg;
    
    self.view.backgroundColor =  ThemeColor;
    
    [self creatSegment];
    
    [self creatScrollView];
    
    [self creatDizhuTableView];
    
    [self creaPartyTableView];
    
    
    [self setDizhuBtn];
    
    [self setPartyBtn];
    
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.dizhuBtn.hidden = NO;
    self.partyBtn.hidden = NO;
}

#pragma mark --partyBtn
- (void)setPartyBtn{
    
    UIButton *partyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrameW*1/7+kScreenFrameW, kScreenFrameH*7/10, r, r)];
    
    [partyBtn setImage:self.xuanfuImg forState:UIControlStateNormal];
    
    
//    partyBtn.layer.masksToBounds = YES;
    partyBtn.layer.cornerRadius = r/2;
    
    partyBtn.clipsToBounds = TRUE;
    
    [self.mainScrollView addSubview:partyBtn];
    [self.mainScrollView bringSubviewToFront:partyBtn];
    
    [partyBtn addTarget:self action:@selector(partyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.partyBtn = partyBtn;
    
    
    CYXuanfuView *partyXuanfu = [[CYXuanfuView alloc] init];
    
    partyXuanfu = kLoadViewWithNIB(@"CYXuanfuView");
    
    //        //设置button完全为圆形：
    //        Button.layer.cornerRadius = 34.0;（该值到一定的程度，就为圆形了。）
    //
    //        Button.layer.borderWidth = 1.0;
    //
    //        Button.layer.borderColor =[UIColor clearColor].CGColor;
    //
    //        Button.clipsToBounds = TRUE;//去除边界
    
    partyXuanfu.frame = CGRectMake(kScreenFrameW*1/7+kScreenFrameW+8,  kScreenFrameH*7/10+4, 0, self.partyBtn.size.height-8);
    
    partyXuanfu.layer.cornerRadius = r/2-8;
    
    [partyXuanfu.leftButton setTitle:@"          我参加的" forState:UIControlStateNormal];
    
    [partyXuanfu.rightButton setTitle:@"发布活动" forState:UIControlStateNormal];
    
    [partyXuanfu.leftButton addTarget:self action:@selector(leftpartyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [partyXuanfu.rightButton addTarget:self action:@selector(rightpartyButtonAction:)   forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.mainScrollView addSubview:partyXuanfu];
    self.partyXuanfu = partyXuanfu;
}




- (void)leftpartyButtonAction:(id)sender{
    
    CYJoinedViewController *new = [[CYJoinedViewController alloc] init];
    
    [self.navigationController pushViewController:new animated:YES];
    
}

- (void)rightpartyButtonAction:(id)sender{
    
    CYPoViewController *new = [[CYPoViewController alloc] init];
    
    new.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
}

- (void)partyBtnAction:(id)sender{
    
    
    if (self.partyTagNum == NO) {
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            
            self.partyXuanfu.frame = CGRectMake(kScreenFrameW+kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 200, self.partyBtn.size.height-8);
            [self.mainScrollView bringSubviewToFront:self.partyBtn];
            
        }];
        
        self.partyTagNum =YES;
        
        
    }else{
        self.partyXuanfu.frame = CGRectMake(kScreenFrameW+kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 0, self.partyBtn.size.height-8);
        
        self.partyTagNum= NO;
    }
    
}


#pragma mark --dizhuBtn

- (void)setDizhuBtn{
    
        UIButton *dizhuBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrameW*1/7, kScreenFrameH*7/10, r, r)];
    
    
        [dizhuBtn setImage:self.xuanfuImg forState:UIControlStateNormal];
    
        dizhuBtn.layer.masksToBounds = YES;
        dizhuBtn.layer.cornerRadius = r/2;
    
        [self.mainScrollView addSubview:dizhuBtn];
        [self.mainScrollView bringSubviewToFront:dizhuBtn];
        
        [dizhuBtn addTarget:self action:@selector(dizhuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dizhuBtn = dizhuBtn;
    
    
    
    CYXuanfuView  *duzhiXuanfu  = [[CYXuanfuView alloc] init];
    
    duzhiXuanfu = kLoadViewWithNIB(@"CYXuanfuView");
    
    duzhiXuanfu.layer.cornerRadius = r/2-8;
    
    duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 0, self.dizhuBtn.size.height-8);
    
    [duzhiXuanfu.leftButton setTitle:@"          我预约的" forState:UIControlStateNormal];
    
    [duzhiXuanfu.rightButton setTitle:@"我要做地主" forState:UIControlStateNormal];
    
    [duzhiXuanfu.leftButton addTarget:self action:@selector(leftdizhuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [duzhiXuanfu.rightButton addTarget:self action:@selector(rightdizhuButtonAction:)   forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.mainScrollView addSubview:duzhiXuanfu];
    
    self.duzhiXuanfu = duzhiXuanfu;
    
}


- (void)leftdizhuButtonAction:(id)sender{
    
}

- (void)rightdizhuButtonAction:(id)sender{
    CYDoDiViewController *new = [[CYDoDiViewController alloc ] init];
    new.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
   
}

- (void)dizhuBtnAction:(id)sender{
    
    if (self.dizhuTagNum == NO) {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 200, self.dizhuBtn.size.height-8);
        [self.mainScrollView bringSubviewToFront:self.dizhuBtn];

    }];
        
        self.dizhuTagNum =YES;
        
        
    }else{
        self.duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 0, self.dizhuBtn.size.height-8);
     
        self.dizhuTagNum= NO;
    }
    
}


#pragma mark -- scrollView

//contentOffset:滑动视图里面的内容的相对位置
//contentInset:滑动视图在外面的相对位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageNum = scrollView.contentOffset.x/kScreenFrameW + 0.5;
    
    self.seg.selectedSegmentIndex = pageNum;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.dizhuBtn.hidden = YES;
    self.partyBtn.hidden = YES;
    self.duzhiXuanfu.frame = CGRectMake(kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 0, self.dizhuBtn.size.height-8);
    self.partyXuanfu.frame = CGRectMake(kScreenFrameW+kScreenFrameW*1/7+8, kScreenFrameH*7/10+4, 0, self.partyBtn.size.height-8);

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

#pragma mark--segment

- (void)creatSegment{
    
    NSArray *arrItems = @[@"叫地主",@"聚会&派对"];
    
  
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arrItems];
    seg.size = CGSizeMake(50, 10);
    seg.center = CGPointMake(kScreenFrameW/2, 44/2);
//    seg.backgroundColor = [UIColor whiteColor];
    seg.tintColor = ThemeColor;
    
    
    
  
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
# pragma mark--tableView

- (void)creatDizhuTableView{
    
    CYDizhuTableView *dizhuTableView = [[CYDizhuTableView alloc] init];
    
    dizhuTableView.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY );
    [self.mainScrollView addSubview:dizhuTableView];
    
   
    
    self.dizhuTableView = dizhuTableView;
    
    
}


- (void)creaPartyTableView{
    
    CYPartyTableView *partyTableView = [[CYPartyTableView alloc] init];
    partyTableView.frame = CGRectMake(kScreenFrameW, 0, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY );
    
    [self.mainScrollView addSubview:partyTableView];
    
    self.partyTableView = partyTableView;
    
    
}


@end
