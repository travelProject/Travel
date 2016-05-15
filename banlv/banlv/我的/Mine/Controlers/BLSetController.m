//
//  BLSetController.m
//  伴旅
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLSetController.h"
#import "BLLogoView.h"
#import "BLAboutUsView.h"
#import "BLFeedbackController.h"

@interface BLSetController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArr;
}

@end

@implementation BLSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BLLogoView *logoView = [BLLogoView loadView];
    logoView.frame = CGRectMake(0, 0, kScreenFrameW, 300);
    [self.view addSubview:logoView];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 300, kScreenFrameW, kScreenFrameH)) style:(UITableViewStylePlain)];
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _dataArr = @[@"关于我们",@"意见反馈",@"清除缓存",@"退出登录"];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        //设置cell的类型UITableViewCellStyleDefault
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    //    cell.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favorite_gray~iphone"]];
    cell.imageView.image = [UIImage imageNamed:@"shoucang"];
    
    return cell;
}
#pragma mark -- UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BLFeedbackController *feedback = [[BLFeedbackController alloc] init];
    switch (indexPath.row) {
        case 0:
           CYLog(@"about us!");
            break;
        case 1:
            CYLog(@"feedback!");
            
            [self.navigationController pushViewController:feedback animated:YES];
            break;
            
        case 2:
            CYLog(@"clear cache!");
            break;
        case 3:
            CYLog(@"log out!");
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
