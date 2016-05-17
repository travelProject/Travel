//
//  FYCityHouseMapVC.m
//  banlv
//
//  Created by lfy on 16/5/17.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseMapVC.h"

@interface FYCityHouseMapVC ()

@end

@implementation FYCityHouseMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
//    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
//    "cityId" : 73,
//    "limitGuestsNum" : 0,
//    "checkOutDate" : 1463414400000,
//    "page" : 1,
//    "userToken" : "NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3",
//    "sex" : 0,
//    "districtId" : 0,
//    "checkInDate" : 1462550400000
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":73,\n\"limitGuestsNum\":0,\n\"checkOutDate\":1463414400000,\n\"page\":1,\n\"userToken\":NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3,\n\"sex\":0,\n\"districtId\":0,\n\"checkInDate\":1462550400000}"];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceByCity.do?";
    
    NSLog(@"接口是:%@",[urlStr encodeURLWithParams:params]);
    
//    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
//        
//        
//        
//    } failur:^(NSError *error) {
//        
//    }];
    
    
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
