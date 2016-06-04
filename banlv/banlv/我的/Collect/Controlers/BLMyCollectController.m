//
//  BLMyCollectController.m
//  伴旅
//
//  Created by scjy on 16/5/15.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLMyCollectController.h"

//房间详细信息类
#import "FYSingleHouseDetailVC.h"

//城市房间cell
#import "FYCityHouseListCell.h"

//城市房间数据模型
#import "FYCityHouseListData.h"

@interface BLMyCollectController () <UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

//存放城市房间的数组
@property(nonatomic,strong) NSMutableArray<FYCityHouseListData *> *cityHouseArr;

@end

@implementation BLMyCollectController

- (NSMutableArray<FYCityHouseListData *> *)cityHouseArr
{
    if (!_cityHouseArr) {
        
        _cityHouseArr = [NSMutableArray array];
    }
    
    return _cityHouseArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    [self initTableView];
    
    [self requestData];
    
}

- (void)initTableView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
        
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH, self.view.width, self.view.height - NavH) style:UITableViewStylePlain];
    

    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#676767"];
    header.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"##676767"];
    
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"##676767"];
    [footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    footer.automaticallyHidden = NO;
    
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FYCityHouseListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"houseCell"];
    
    [self.view addSubview:self.tableView];

    
}

- (void)downRefresh
{
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CollectionHouse"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        if (error)
        {
            //进行错误处理
        }else if (array)
        {
            
            [self.cityHouseArr removeAllObjects];
            
            [array enumerateObjectsUsingBlock:^(BmobObject   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *dict = [obj.mj_keyValues objectForKey:@"bmobDataDic"];
                
                FYCityHouseListData *data = [FYCityHouseListData mj_objectWithKeyValues:dict];
                
                [self.cityHouseArr addObject:data];
                
            }];
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            
        }
        
        
    }];

    
    
}

- (void)upRefresh
{
    
   
     
    
  
}

- (void)requestData
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CollectionHouse"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        if (error)
        {
            //进行错误处理
        }else if (array)
        {
            

            [array enumerateObjectsUsingBlock:^(BmobObject   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *dict = [obj.mj_keyValues objectForKey:@"bmobDataDic"];
                
                FYCityHouseListData *data = [FYCityHouseListData mj_objectWithKeyValues:dict];
                
                [self.cityHouseArr addObject:data];
                
            }];
            
            [self.tableView reloadData];
            
        }
        
        
    }];
    
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
    
    FYSingleHouseDetailVC *singleHouseDetailVC = [[FYSingleHouseDetailVC alloc] init];
    
    singleHouseDetailVC.spaceId = self.cityHouseArr[indexPath.row].spaceId;
    
    [self.navigationController pushViewController:singleHouseDetailVC animated:YES];
    
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
