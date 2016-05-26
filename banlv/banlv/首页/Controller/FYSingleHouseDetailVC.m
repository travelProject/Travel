//
//  FYSingleHouseDetailVC.m
//  banlv
//
//  Created by lfy on 16/5/26.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSingleHouseDetailVC.h"

@interface FYSingleHouseDetailVC ()

@property(nonatomic,strong)FYAFNetworkingManager *manager;

@end

@implementation FYSingleHouseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.manager = [FYAFNetworkingManager manager];
    
    
    
    [self requestData];
    
}

- (void)requestData
{

    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"spaceId\":%@,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"}",self.spaceId];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceInfo.do";
    
    NSLog(@"接口地址:%@",[urlStr encodeURLWithParams:params]);
    
    [self.manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
    }];
}

- (void)setSpaceId:(NSString *)spaceId
{
    _spaceId = spaceId;
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
