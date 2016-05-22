//
//  CYPartyTableView.m
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYPartyTableView.h"
#import "CYPartyCellData.h"
#import "CYPartyCell.h"

@interface CYPartyTableView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)NSArray<CYPartyCellData *> *dataArr;

@end

@implementation CYPartyTableView

- (NSArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr  = [[NSArray alloc] init];
    }
    return _dataArr;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
            self.dataSource = self;
        self.backgroundColor = ThemeColor;
        
        [self request];
    }
    
    return self;
    
}

#pragma mark --UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *indentifier=@"CYPartyCell";
    
    CYPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = kLoadViewWithNIB(indentifier);
    }
    
    cell.address.text = [NSString stringWithFormat:@"%@ - %@",self.dataArr[indexPath.row].cityName,self.dataArr[indexPath.row].address];
    NSString *str = self.dataArr[indexPath.row].avatar;
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:str]];
    cell.iconView.layer.cornerRadius = cell.iconView.size.height/2.f;
    
    cell.title.text =self.dataArr[indexPath.row].title;
    
    cell.price.text =[NSString stringWithFormat:@"¥%@/人" ,self.dataArr[indexPath.row].price];
    
    
    cell.joinCount.text = [NSString stringWithFormat:@"%@人报名",self.dataArr[indexPath.row].joinCount];
    
    NSString *iii = self.dataArr[indexPath.row].pics[0];
    
    [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:iii]];
    
    
    NSString *startTime = self.dataArr[indexPath.row].startTime;
    
    NSString *endTime = self.dataArr[indexPath.row].endTime;
    
    cell.time.text = [NSString stringWithFormat:@"%@ ~ %@",startTime,endTime];
    
//    NSLog(@"%@",cell.time.text);
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 410;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了%@",self.dataArr[indexPath.row]);
    

        
        self.partyRow(indexPath.row);
        
        
        
        
        
    
}

- (void)request{
//    NSString *search = nil;
    
//    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"page\":1}"];
    
    NSString *urlStr = @"http://www.shafalvxing.com/party/queryPartyWithPage.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        NSArray *jsonArr = [[[responseObject objectForKey:@"data"]objectForKey:@"parties" ] objectForKey:@"result"];
        
        
        self.dataArr = [CYPartyCellData mj_objectArrayWithKeyValuesArray:jsonArr];
        
        [self reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
