//
//  BLSetController.m
//  伴旅
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLSetController.h"
#import "BLFeedbackController.h"
#import "BLSetTableView.h"
#import "BLAboutUsView.h"

@interface BLSetController ()
{
    UIScrollView *_scrollView;
    UITableView *_tableView;
   
   
    
    
}

@end

@implementation BLSetController
//隐藏NavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
//退出该控制器时还原,否则会影响到下一级的controlelr
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
   
    
    
    
    [self setUpScrollView];
    [self setUPSetTableView];
    [self setUpAboutUsView];
    [self setUpCancelBtn];
    

}

- (void)setUpScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, kScreenFrameW, 300)];
    _scrollView.contentSize = CGSizeMake(kScreenFrameW *2,0);
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
}
//添加setTableView
- (void)setUPSetTableView{
     BLSetTableView *setTableView = [[BLSetTableView alloc] initWithFrame:(CGRectMake(20, 0, kScreenFrameW - 40,300))];
    setTableView.backgroundColor = [UIColor blueColor];
    //在block体中,局部变量要用__weak修饰（弱引用）,防止循环引用
    __weak typeof(self) mySelf = self;
    setTableView.selectRowBlock = ^(NSInteger row){
        switch (row) {
            case 0:
                CYLog(@"about us!");
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrollView.contentOffset = CGPointMake(kScreenFrameW, 0);
                }];
            }
                break;
            case 1:
                CYLog(@"feedback!");
            {
                BLFeedbackController *feedback = [[BLFeedbackController alloc] init];
                [mySelf.navigationController pushViewController:feedback animated:YES];
                break;
            }
                
            case 2:
                CYLog(@"clear cache!");
                break;
            case 3:
                CYLog(@"log out!");
                break;
            default:
                break;
        }
    };
    
    [_scrollView addSubview:setTableView];
}
- (void)setUpAboutUsView{
    BLAboutUsView *aboutUsView = [[BLAboutUsView alloc] initWithFrame:CGRectMake(kScreenFrameW, 0, kScreenFrameW, 180)];
    [_scrollView addSubview:aboutUsView];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake( 50, kScreenFrameH - 80, 30,30);
//    [backBtn setImage:[UIImage imageNamed:@"lanfanhui"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
}
//- (void)back:(id)ssender{
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        _scrollView.contentOffset = CGPointMake(-kScreenFrameW, 0);
//    }];
//}

//添加返回按钮
- (void)setUpCancelBtn{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    cancelBtn.center = CGPointMake(kScreenFrameW/2, kScreenFrameH -30);
    //    cancelBtn.size = CGSizeMake(30, 30);
    cancelBtn.frame = CGRectMake(kScreenFrameW/2 - 15,kScreenFrameH - 80 ,30, 30);
    [cancelBtn setImage:[UIImage imageNamed:@"lanfanhui"] forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(cancelSet:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:cancelBtn];
    
}
//返回按钮 返回到上一级
- (void)cancelSet:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
