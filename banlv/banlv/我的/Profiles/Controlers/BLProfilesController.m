//
//  BLProfilesController.m
//  伴旅
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLProfilesController.h"
#import "BLEditProfilesController.h"
#import "BLBannerView.h"
@interface BLProfilesController ()
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BLProfilesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(edit:)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    BLBannerView *bannerView = [[[NSBundle mainBundle] loadNibNamed:@"BLBannerView" owner:nil options:nil] firstObject];
    
    bannerView.frame = CGRectMake(0.f, 64.f, kScreenFrameW, 300);
    
    [self.view addSubview:bannerView];
    self.tableView = [[UITableView alloc] initWithFrame:kScreenFrame style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
}

- (void)edit:(id)sender{
    BLEditProfilesController *edit = [[BLEditProfilesController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
