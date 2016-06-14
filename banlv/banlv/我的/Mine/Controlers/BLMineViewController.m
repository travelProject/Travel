//
//  BLMineViewController.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLMineViewController.h"
#import "BLProfilesController.h"
#import "BLSetController.h"
#import "BLMyWalletController.h"
#import "BLSetController.h"
#import "BLMyCollectController.h"
#import "BLNavigationController.h"
#import "BLShareController.h"

@interface BLMineViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userPicView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSArray *picArr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewH;

@end

@implementation BLMineViewController

//隐藏NavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
 
    
}
//退出该控制器时还原,否则会影响到下一级的controlelr
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = kScreenFrame;
    
    if (![UserInfo sharedUserInfo].userId) {
       
        self.userPicView.image = [UIImage imageNamed:@"160x160default"];
        
        self.userNameLab.text = @"用户名";
    }
    
    self.userPicView.layer.cornerRadius = self.userPicView.width / 2;
    self.userPicView.layer.masksToBounds = YES;
    
    self.dataArr = @[@"我的钱包",@"我的房源",@"我的收藏",@"分享给好友",@"设置"];
    self.picArr = @[@"qianbao",@"fabufangyuan",@"shoucang",@"fenxiang_hui",@"shezhi"];
    
    //添加点击手势
    UITapGestureRecognizer *tapPic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToProfiles:)];
    
    UITapGestureRecognizer *tapLab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToProfiles:)];
    
    self.userNameLab.userInteractionEnabled = YES;
    self.userPicView.userInteractionEnabled = YES;
    
    [self.userPicView addGestureRecognizer:tapPic];
    [self.userNameLab addGestureRecognizer:tapLab];
    
}

- (void)jumpToProfiles:(id)sender{
    
    if (![UserInfo sharedUserInfo].userId) {
        
        BLLoginVC *loginVC = [[BLLoginVC alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
    }else
    {
        BLProfilesController *profiles = [[BLProfilesController alloc] init];
        [self.navigationController pushViewController:profiles animated:YES];
    }
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
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.f];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
    cell.imageView.image = [UIImage imageNamed:self.picArr[indexPath.row]];
    
    //不显示高亮状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0:
        {
            BLMyWalletController *wallet = [[BLMyWalletController alloc] init];
            
            [self.navigationController pushViewController:wallet animated:YES];
        }
            break;
        case 2:
        {
            BLMyCollectController *collect = [[BLMyCollectController alloc] init];
            
            [self.navigationController pushViewController:collect animated:YES];
            break;
        }
        case 3:
        {
            BLShareController *share = [[BLShareController alloc] init];
            [self presentViewController:share animated:YES completion:nil];
            
        }
            break;
        case 4:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            BLSetController *set = [[BLSetController alloc] init];
            BLNavigationController *nav = [[BLNavigationController alloc] initWithRootViewController:set];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}


- (void)updateViewConstraints
{
    
    [super updateViewConstraints];
    
    self.tableViewH.constant = self.dataArr.count * 50.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
