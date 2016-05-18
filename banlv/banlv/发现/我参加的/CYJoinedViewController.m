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
    
    mySeg.defaultPerColor = [UIColor blackColor];
    
    mySeg.perColor = [UIColor redColor];
    
    mySeg.underLayerBackgroudColor = [UIColor redColor];
    
    mySeg.selectIdx = 0;
    

    
    
    
    [self.view addSubview:mySeg];
    
    self.mySeg = mySeg;

    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mySegH + 64, kScreenFrameW, kScreenFrameH - mySegH - 64)];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    
    mainScrollView.delegate = self;
    
    mainScrollView.pagingEnabled = YES;
    mainScrollView.backgroundColor = [UIColor cyanColor];
    
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW *2, kScreenFrameH - self.tabBarController.tabBar.height - mySegH - 64);
    
    
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    UIButton *t = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 30, 30)];
    t.backgroundColor = [UIColor redColor];
    [mainScrollView addSubview:t];
    
    mySeg.changeCount = ^(NSInteger a){
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGPoint point = CGPointMake(a * kScreenFrameW, 0);
            
            mainScrollView.contentOffset = point;
            
        }];
       
        
    };
   
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageNum = scrollView.contentOffset.x/kScreenFrameW + 0.5;
    
    self.mySeg.selectIdx = pageNum;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
