//
//  CYJoinedViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//

# define mySegH 36.f
#import "CYJoinedViewController.h"
#import "CYMySegment.h"

@interface CYJoinedViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong)CYMySegment *mySeg;

@property(nonatomic, strong)UIScrollView *mainScrollView;

@end

@implementation CYJoinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我参加的";
    
    CYMySegment *mySeg = [[CYMySegment alloc] initWithFrame:CGRectMake(0, 64, kScreenFrameW, mySegH) withItems:@[@"关注",@"精选"]];
    
    mySeg.segmentBgColor = [UIColor whiteColor];
    
    mySeg.defaultPerColor = [UIColor blackColor ];
    
    mySeg.perColor = ThemeColor;
    
    mySeg.underLayerBackgroudColor =ThemeColor;
    
    mySeg.selectIdx = 0;
    
    [self.view addSubview:mySeg];
    
    self.mySeg = mySeg;

    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mySegH + 64, kScreenFrameW, kScreenFrameH - mySegH - 64)];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    
    mainScrollView.delegate = self;
    
    mainScrollView.pagingEnabled = YES;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW *2, kScreenFrameH - self.tabBarController.tabBar.height - mySegH - 64);
    
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    
    
    
    mySeg.changeCount = ^(NSInteger a){
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGPoint point = CGPointMake(a * kScreenFrameW, 0);
            
            mainScrollView.contentOffset = point;
            
        }];
    };
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenFrameW - 100)/2, 200, 100, 100)];
    img.image = [UIImage imageNamed:@"orderListNoData"];
    [mainScrollView addSubview:img];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenFrameW - 100)/2, 308, 100, 22)];
    lab.text = @"没有订单哦";
    lab.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:lab];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenFrameW - 100)/2+kScreenFrameW, 200, 100, 100)];
    img1.image = [UIImage imageNamed:@"orderListNoData"];
    [mainScrollView addSubview:img1];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenFrameW - 100)/2+kScreenFrameW, 308, 100, 22)];
    lab1.text = @"没有订单哦";
    lab1.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:lab1];
    
   
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageNum = scrollView.contentOffset.x/kScreenFrameW + 0.5;
    
    self.mySeg.selectIdx = pageNum;
    
    
    
}
@end
