//
//  CYPoViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//
# define poBtnH 50.f

#import "CYPoViewController.h"
#import "CYPoHeaderView.h"

@interface CYPoViewController ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation CYPoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.title = @"发布";
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - poBtnH) style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor redColor];
    
    myTableView.delegate = self;
    
    myTableView.dataSource = self;
    
    CYPoHeaderView *CYHeader = [[CYPoHeaderView alloc] init];
    
    
    CYHeader.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH * 0.78);
    
    
    myTableView.tableHeaderView = CYHeader;
    
    
    
    
    
    [self.view addSubview:myTableView];
    
    UIButton *poBtn = [[UIButton alloc] init];
    poBtn.frame = CGRectMake(0, kScreenFrameH - poBtnH, kScreenFrameW, poBtnH);
    poBtn.backgroundColor = [UIColor greenColor];
    [poBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.view addSubview:poBtn];
    
    
    
  

    

}
//有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1||section ==0) {
        return 2;
    }else {
        return 1;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *indentifier = @"indentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        
    }
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor yellowColor];
        
        if (indexPath.row ==0) {
            cell.textLabel.text = @"开始时间";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"结束时间";
        }
        
//        cell.textLabel.text = @"dsfdsfs";
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"活动价格";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"人数限制";
        }
        
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"活动地址";
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"实名认证";
    }
    
    
    
    
    
    return cell;
    
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
