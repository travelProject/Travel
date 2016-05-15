//
//  CYPartyTableView.m
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYPartyTableView.h"

@interface CYPartyTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CYPartyTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
            self.dataSource = self;
        
        [self request];
    }

    
    
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *indentifier=@"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 22;
}


- (void)request{
//    NSString *search = nil;
    
//    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"page\":1}"];
    
    NSString *urlStr = @"http://www.shafalvxing.com/party/queryPartyWithPage.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
    //http://www.shafalvxing.com/channel/getLocalServiceList.do
    //    bizParams：{
    //          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2",
    //          "page" : 1
    //    }
    
//    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
//        
////        NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
//        
//        
////        self.dataArr = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:jsonArr];
//        
////        [self reloadData];
//        
//        
//    } failur:^(NSError *error) {
//        
//        NSLog(@"error : %@",error);
//        
//    }];
}


@end
