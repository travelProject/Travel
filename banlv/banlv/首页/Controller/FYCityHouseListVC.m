//
//  FYCityHouseList.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseListVC.h"

//城市房间数据模型
#import "FYCityHouseListData.h"

//城市房间cell
#import "FYCityHouseListCell.h"

#import "FYCityHouseMapVC.h"

@interface FYCityHouseListVC () <UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

//存放城市房间的数组
@property(nonatomic,strong) NSArray<FYCityHouseListData *> *cityHouseArr;

@end

@implementation FYCityHouseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dizhi"] style:UIBarButtonItemStyleDone target:self action:@selector(swithToMapStyle)];
    
    [self initTableView];
    
    [self requestData];
    
    }

- (void)initTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FYCityHouseListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"houseCell"];
    
    [self.view addSubview:self.tableView];
}

- (void)requestData
{
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%@,\n\"limitGuestsNum\":0,\n\"checkOutDate\":0,\n\"page\":1,\n\"userToken\":\"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3\",\n\"sex\":0,\n\"districtId\":0,\n\"checkInDate\":0}",self.cityId];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceByCity.do?";

    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        NSArray *cityHouseArr = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
        
        self.cityHouseArr = [FYCityHouseListData mj_objectArrayWithKeyValuesArray:cityHouseArr];
        
        [self.tableView reloadData];
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];
    
    
}

//切换到地图模式
- (void)swithToMapStyle
{
    FYCityHouseMapVC *mapVC = [[FYCityHouseMapVC alloc] init];
    
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设为不选中（不变灰色）
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击的房间ID:%@",self.cityHouseArr[indexPath.row].spaceId);
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityHouseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYCityHouseListCell *houseCell = [tableView dequeueReusableCellWithIdentifier:@"houseCell" forIndexPath:indexPath];
    
    houseCell.cityHouseData = self.cityHouseArr[indexPath.row];
    
    return houseCell;
}

//cityId的setter方法
- (void)setCityId:(NSString *)cityId
{
    _cityId = cityId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
