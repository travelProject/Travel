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

@interface BLSetController () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UITableView *_tableView;
    UIButton *_backBtn;
   
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
    
    
    [self initLogoView];
    [self setUpScrollView];
    [self setUPSetTableView];
    [self setUpAboutUsView];
    [self setUpCancelBtn];
    

}

- (void)initLogoView
{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 70) / 2, 90, 70, 70)];
    logoView.image = [UIImage imageNamed:@"IconPic"];
    logoView.layer.cornerRadius = 10.f;
    logoView.layer.masksToBounds = YES;
    
    [self.view addSubview:logoView];
    
    UILabel *appNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(logoView.frame), CGRectGetMaxY(logoView.frame) + 10.f, logoView.width, 20.f)];
    appNameLab.textAlignment = NSTextAlignmentCenter;
    appNameLab.text = @"伴旅";
    appNameLab.font = [UIFont systemFontOfSize:13.f];
    
    [self.view addSubview:appNameLab];
    
    UILabel *appVersionLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(appNameLab.frame), CGRectGetMaxY(appNameLab.frame) + 5.f, appNameLab.width, 15.f)];
    appVersionLab.textAlignment = NSTextAlignmentCenter;
    appVersionLab.text = @"V1.0.0";
    appVersionLab.font = [UIFont systemFontOfSize:11.f];
    
    [self.view addSubview:appVersionLab];
    
}

- (void)setUpScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, kScreenFrameW, 400)];
    _scrollView.contentSize = CGSizeMake(kScreenFrameW *2,0);
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
}

//添加setTableView
- (void)setUPSetTableView{
    
     BLSetTableView *setTableView = [[BLSetTableView alloc] initWithFrame:(CGRectMake(20, 0, kScreenFrameW - 40,400))];
    
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
                CYLog(@"review for us!");
                break;
                
            case 3:
                CYLog(@"clear cache!");
                break;
                
            case 4:
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
    
}

//添加返回按钮
- (void)setUpCancelBtn{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancelBtn.frame = CGRectMake(kScreenFrameW/2 - 15,kScreenFrameH - 50 ,30, 30);
    [cancelBtn setImage:[UIImage imageNamed:@"center_exit_button"] forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(cancelSet:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:cancelBtn];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backBtn.frame = CGRectMake(15,kScreenFrameH - 50 ,30, 30);
    [_backBtn setImage:[UIImage imageNamed:@"center_back_button"] forState:(UIControlStateNormal)];
    [_backBtn addTarget:self action:@selector(backToFormer) forControlEvents:(UIControlEventTouchUpInside)];
    _backBtn.hidden = YES;
    
    [self.view addSubview:_backBtn];
    
}

//返回按钮 返回到上一级
- (void)cancelSet:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backToFormer
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x == _scrollView.width) {
        
        _backBtn.hidden = NO;
        
    }else if (_scrollView.contentOffset.x == 0)
    {
        _backBtn.hidden = YES;
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
