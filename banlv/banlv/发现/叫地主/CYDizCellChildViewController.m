//
//  CYDizCellChildViewController.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDizCellChildViewController.h"

@interface CYDizCellChildViewController ()

@end

@implementation CYDizCellChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ThemeColor;
    [self request];
}

- (void)request{
    
//    三级页面：http://www.shafalvxing.com/channel/localServiceDetail.do
//    bizParams：{
//          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2",
//          "localServiceId" : 262
//    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    NSLog(@"%@".self.i);
    self.i = @"262";
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"localServiceId\":%@}",self.i];
    
    NSString *urlStr = @"http://www.shafalvxing.com/channel/localServiceDetail.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        NSArray *jsonArr =[responseObject objectForKey:@"data"];
        
//        CYParCellChildData *myData  = [CYParCellChildData  mj_objectWithKeyValues:jsonArr];
//        
//        self.myData = myData;
//        [self addIfo];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


@end
