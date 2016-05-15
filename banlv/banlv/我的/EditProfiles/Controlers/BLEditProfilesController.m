//
//  BLEditProfilesController.m
//  伴旅
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLEditProfilesController.h"
#import "BLBannerView.h"
@interface BLEditProfilesController ()

@end

@implementation BLEditProfilesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(done:)];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    BLBannerView *bannerView = [[[NSBundle mainBundle] loadNibNamed:@"BLBannerView" owner:nil options:nil] firstObject];
    
    bannerView.frame = CGRectMake(0.f, 64.f, kScreenFrameW, 200);
    
    [self.view addSubview:bannerView];
}
- (void)done:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
