//
//  CYDoDiViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//
# define poBtnH 50.f

#import "CYDoDiViewController.h"
#import "CYDoDizhuView.h"

@interface CYDoDiViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CYDoDiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"我要做地主";
    
    CYDoDizhuView *header = [[CYDoDizhuView alloc] init];
   header.frame = CGRectMake(0, 0, kScreenFrameW, 352);
    
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - poBtnH) style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor redColor];
    
    myTableView.delegate = self;
    
    myTableView.dataSource = self;
    
    myTableView.tableHeaderView = header;
    
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1||section ==0) {
        return 3;
    }else {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *indentifier = @"indentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        NSLog(@"%f",cell.size.height);
    }
    if (indexPath.section == 1) {
        cell.backgroundColor = [UIColor yellowColor];
        
        if (indexPath.row == 0) {
            cell.textLabel.center = CGPointMake(cell.origin.x / 2, cell.origin.y / 2);
             cell.textLabel.text = @"可提供的服务";
        }
        
        if (indexPath.row ==1) {
            cell.textLabel.text = @"跟拍";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"伴游";
        }
        
        //        cell.textLabel.text = @"dsfdsfs";
    }

    return cell;
}

@end
