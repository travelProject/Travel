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
@end

@implementation BLProfilesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(edit:)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    BLBannerView *bannerView = [[[NSBundle mainBundle] loadNibNamed:@"BLBannerView" owner:nil options:nil] firstObject];
    
    bannerView.frame = CGRectMake(0.f, 64.f, kScreenFrameW, 200);
    
    [self.view addSubview:bannerView];
    
    
    
//    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
//    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, 200) collectionViewLayout:flow];
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    [self.collectionView reg]
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.pagingEnabled = YES;
//    [self.view addSubview:self.collectionView];
    
    
    
}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    return <#expression#>
//    
//}
- (void)edit:(id)sender{
    BLEditProfilesController *edit = [[BLEditProfilesController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
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
