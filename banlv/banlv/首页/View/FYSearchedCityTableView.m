//
//  FYSearchedCityTableView.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSearchedCityTableView.h"

@interface FYSearchedCityTableView () <UITableViewDelegate ,UITableViewDataSource >

@property(nonatomic,strong) UITableView *searchedTableView;

@end

@implementation FYSearchedCityTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSearchedTableView];
        
//        [self requestData];
        
    }
    return self;
}

//搜索之后显示的城市列表
- (void)initSearchedTableView
{
    self.searchedTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    
    self.searchedTableView.contentInset = UIEdgeInsetsMake(NavH, 0, 0, 0);
    
    self.searchedTableView.backgroundColor = [UIColor greenColor];
    
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
    NSLog(@"点击的城市id");
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.searchedTableView dequeueReusableCellWithIdentifier:@"searchedCell"];
    
    cell.textLabel.text = @"杭州";
    
    return cell;
}

//setter方法
- (void)setSearchWord:(NSString *)searchWord
{
    _searchWord = searchWord;
    
    
}

//请求数据
- (void)requestData
{
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *keyWord = @"上";
    
    NSString *urlString = [NSString stringWithFormat:@"bizParams={\n\"key\":\"%@\",\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"\n}",keyWord];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://www.shafalvxing.com/city/searchCity.do?%@",[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSLog(@"url:%@",urlStr);
    
    [manager GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];
}

@end
