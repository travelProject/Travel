//
//  BLMineViewController.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLMineViewController.h"
#import "BLIconView.h"
#import "MMDrawerController.h"
#import "BLProfilesController.h"
#import "BLSetController.h"
#import "BLMyWalletController.h"
#import "BLSetController.h"
#import "BLMyCollectController.h"
@interface BLMineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MMDrawerController *_drawerController;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *dataArr;

@end

@implementation BLMineViewController



//隐藏NavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationController.hidesBottomBarWhenPushed = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStylePlain) target:self action:@selector(showRightDrawer:)];
    
    //添加iconView
    BLIconView *iconView = [BLIconView loadView];
    iconView.backgroundColor = [UIColor cyanColor];
    iconView.frame = CGRectMake(0, 0, self.view.width,250);
    [self.view addSubview:iconView];
    //给midView添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToProfiles:)];
    [iconView.midView addGestureRecognizer:tap];
    //设置从navigationBar下缘开始
    if(iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 250, kScreenFrameW, kScreenFrameH)) style:(UITableViewStylePlain)];
    self.tableView.scrollEnabled = NO;//不允许滑动
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.dataArr = @[@"我的钱包",@"我的房源",@"可租日期管理",@"我的收藏",@"分享给好友",@"设置"];
    [self.view addSubview:self.tableView];
    
    
    
}
//退出该控制器时还原,否则会影响到下一级的controlelr
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.hidesBottomBarWhenPushed = YES;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStylePlain) target:self action:@selector(showRightDrawer:)];
//        
//    //添加iconView
//    BLIconView *iconView = [BLIconView loadView];
//    iconView.backgroundColor = [UIColor cyanColor];
//    iconView.frame = CGRectMake(0, 0, self.view.width,250);
//    [self.view addSubview:iconView];
//    //给midView添加点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToProfiles:)];
//    [iconView.midView addGestureRecognizer:tap];
//    //设置从navigationBar下缘开始
//    if(iOS7) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    }
//    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 250, kScreenFrameW, kScreenFrameH)) style:(UITableViewStylePlain)];
//    self.tableView.scrollEnabled = NO;//不允许滑动
////    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.dataArr = @[@"我的钱包",@"我的房源",@"我的收藏",@"分享给好友"];
//    [self.view addSubview:self.tableView];
//
}
- (void)showRightDrawer:(id)sender{
    
}
- (void)jumpToProfiles:(id)sender{
    
    NSLog(@"1111111111");
    
    BLProfilesController *profiles = [[BLProfilesController alloc] init];
    [self.navigationController pushViewController:profiles animated:YES];
    
    
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
   
    if (!cell) {
        //设置cell的类型UITableViewCellStyleValue1
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        //设置右侧附件类型（箭头）
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.detailTextLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor blackColor];
//    cell.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favorite_gray~iphone"]];
    cell.imageView.image = [UIImage imageNamed:@"shoucang"];

    return cell;
}
#pragma mark -- UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BLMyWalletController *wallet = [[BLMyWalletController alloc] init];
    BLMyCollectController *collect = [[BLMyCollectController alloc] init];
    BLSetController *set = [[BLSetController alloc] init];

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:wallet animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:collect animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:set animated:YES];
            break;
            
        default:
            break;
    }
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
