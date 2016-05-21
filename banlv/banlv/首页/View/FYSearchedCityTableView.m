//
//  FYSearchedCityTableView.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSearchedCityTableView.h"

//搜索到的城市模型
#import "FYSingleCityData.h"

//城市民宿列表
#import "FYCityHouseListVC.h"

@interface FYSearchedCityTableView () <UITableViewDelegate ,UITableViewDataSource >

@property(nonatomic,strong) UITableView *searchedTableView;

@property(nonatomic,strong) NSArray<FYSingleCityData *> *searchedCityArr;

@end

@implementation FYSearchedCityTableView

//懒加载
- (NSArray *)searchedCityArr
{
    if (!_searchedCityArr) {
        
        _searchedCityArr = [[NSArray alloc] init];
    }
    
    return _searchedCityArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSearchedTableView];
        
    }
    return self;
}

//搜索之后显示的城市列表
- (void)initSearchedTableView
{
    self.searchedTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    
    self.searchedTableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    self.searchedTableView.contentInset = UIEdgeInsetsMake(NavH, 0, 0, 0);
    
    self.searchedTableView.delegate = self;
    self.searchedTableView.dataSource = self;
    
    [self.searchedTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchedCell"];
    
    [self addSubview:self.searchedTableView];
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYCityHouseListVC *cityHouseListVC = [[FYCityHouseListVC alloc] init];
    
    cityHouseListVC.cityId = self.searchedCityArr[indexPath.row].ID;
    
    cityHouseListVC.cityName = self.searchedCityArr[indexPath.row].cityNameCh;
    
    [self.myHostVC.navigationController pushViewController:cityHouseListVC animated:YES];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchedCityArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.searchedTableView dequeueReusableCellWithIdentifier:@"searchedCell"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:13.5f];
    
    cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    cell.textLabel.text = self.searchedCityArr[indexPath.row].cityNameCh;
    
    return cell;
}

//setter方法
- (void)setSearchWord:(NSString *)searchWord
{
    _searchWord = searchWord;
    
    [self requestData];
}

- (void)setMyHostVC:(UIViewController *)myHostVC
{
    _myHostVC = myHostVC;
}
  
//请求数据
- (void)requestData
{
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"key\":\"%@\",\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"\n}",self.searchWord];
    
    NSString *urlStr = @"http://www.shafalvxing.com/city/searchCity.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        NSArray *jsonArr = [responseObject objectForKey:@"data"];
        
        self.searchedCityArr = [FYSingleCityData mj_objectArrayWithKeyValuesArray:jsonArr];
        
        //刷新搜索表格
        [self.searchedTableView reloadData];
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];

}

@end
