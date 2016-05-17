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

    
//    "cityId" : 73,
//    "limitGuestsNum" : 0,
//    "checkOutDate" : 0,
//    "districtId" : 0,
//    "sex" : 0,
//    "checkInDate" : 0,
//    "userToken" : “NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3"
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":73,\n\"limitGuestsNum\":0,\n\"checkOutDate\":0,\n\"districtId\":0,\n\"sex\":0,\n\"sex\":0,\n\"checkInDate\":0,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"\n}"];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSpaceByLatLng.do?";
    
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
