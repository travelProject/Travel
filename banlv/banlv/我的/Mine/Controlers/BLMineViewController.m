//
//  BLMineViewController.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLMineViewController.h"
#import "BLIconView.h"
#import "BLMineTableView.h"
#import "BLProfilesController.h"
#import "BLSetController.h"
#import "BLMyWalletController.h"
#import "BLSetController.h"
#import "BLMyCollectController.h"
#import "BLNavigationController.h"
#import "BLShareController.h"

@implementation BLMineViewController

//隐藏NavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self setUpIconView];
    [self setUpMineTableView];
    //设置从navigationBar下缘开始
    if(iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
}
//退出该控制器时还原,否则会影响到下一级的controlelr
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
//添加iconView
- (void)setUpIconView{
    BLIconView *iconView = [BLIconView loadView];
    iconView.backgroundColor = [UIColor cyanColor];
    iconView.frame = CGRectMake(0, 0, self.view.width,250);
    [self.view addSubview:iconView];
    //给midView添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToProfiles:)];
    [iconView.midView addGestureRecognizer:tap];
    
}
//添加mineTableView
- (void)setUpMineTableView{
    BLMineTableView *mineTable = [[BLMineTableView alloc] initWithFrame:CGRectMake(0, 250, kScreenFrameW, kScreenFrameH - 250)];
    //在block体中,局部变量要用__weak修饰（弱引用）,防止循环引用
    __weak typeof(self) mySelf = self;
    mineTable.selectRowBlock = ^(NSInteger row){
        switch (row) {
            case 0:
            {
                BLMyWalletController *wallet = [[BLMyWalletController alloc] init];
                
                [mySelf.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 3:
            {
                BLMyCollectController *collect = [[BLMyCollectController alloc] init];
                
                [mySelf.navigationController pushViewController:collect animated:YES];
                break;
            }
            case 4:
            {
                BLShareController *share = [[BLShareController alloc] init];
                [mySelf.navigationController pushViewController:share animated:YES];
            }
                break;
            case 5:
            {
                [mySelf dismissViewControllerAnimated:YES completion:nil];
                BLSetController *set = [[BLSetController alloc] init];
                BLNavigationController *nav = [[BLNavigationController alloc] initWithRootViewController:set];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:mineTable];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)jumpToProfiles:(id)sender{
    
    BLProfilesController *profiles = [[BLProfilesController alloc] init];
    [self.navigationController pushViewController:profiles animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
