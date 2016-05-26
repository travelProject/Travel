//
//  FYCityHouseList.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseListVC.h"

//城市房间cell
#import "FYCityHouseListCell.h"

//更多筛选条件
#import "FYMoreChoose.h"

//筛选条件控制器
#import "FYMoreChooseVC.h"

//地图模式控制器
#import "FYCityHouseMapVC.h"

//选择日期
#import "FYChooseDateView.h"

@interface FYCityHouseListVC () <UITableViewDelegate ,UITableViewDataSource ,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) FYChooseDateView *chooseDateView;

@property(nonatomic,strong) FYMoreChoose *moreChoose;

@property(nonatomic,strong)UIView *bothView;

@property(nonatomic,strong) FYAFNetworkingManager *manager;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSInteger hasNext;

@property(nonatomic,strong)ZFChooseTimeViewController *chooseDateVC;

@end

@implementation FYCityHouseListVC

- (NSMutableArray<FYCityHouseListData *> *)cityHouseArr
{
    if (!_cityHouseArr) {
        
        _cityHouseArr = [NSMutableArray array];
    }
    
    return _cityHouseArr;
}

- (NSInteger)page
{
    if (!_page) {
        
        _page = 1;
    }
    
    return _page;
}

- (NSInteger)limitGuestsNum
{
    if (!_limitGuestsNum) {
        
        _limitGuestsNum = 0;
    }
    
    return _limitGuestsNum;
}

- (NSMutableArray *)spaceTypes
{
    if (!_spaceTypes) {
        
        _spaceTypes = [NSMutableArray array];
    }
    
    return _spaceTypes;
}

- (NSInteger)sex
{
    if (!_sex) {
        
        _sex = 0;
    }
    
    return _sex;
}

- (NSInteger)chooseType
{
    if (!_chooseType) {
        
        _chooseType = 1;
    }
    
    return _chooseType;
}

- (NSMutableArray *)selectDateArr
{
    if (!_selectDateArr) {
        
        _selectDateArr = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    }
    
    return _selectDateArr;
}

- (CGFloat)startPrice
{
    if (!_startPrice) {
        
        _startPrice = 0.0;
    }
    
    return _startPrice;
}

- (CGFloat)endPrice
{
    if (!_endPrice) {
        
        _endPrice = 199.9;
    }
    
    return _endPrice;
}

- (NSDate *)getDateFromString:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return [format dateFromString:dateStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题文字样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]}];
    
    self.title = self.cityName;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dizhi"] style:UIBarButtonItemStyleDone target:self action:@selector(swithToMapStyle)];
    
    self.manager = [FYAFNetworkingManager manager];
    
    [self initTableView];
    
    self.chooseDateVC = [[ZFChooseTimeViewController alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, self.view.height)];
    
    __weak typeof(self) mySelf = self;
    
    self.chooseDateVC.returnDateBlock = ^(NSMutableArray *selectedDateArr)
    {
        mySelf.selectDateArr = selectedDateArr;
        
        NSString *dateInStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[0][0],mySelf.selectDateArr[0][1],mySelf.selectDateArr[0][2]];
        NSDate *dateIn = [mySelf getDateFromString:dateInStr];
        
        NSInteger liveIn = (NSInteger)[dateIn timeIntervalSince1970];
        
        NSString *dateOutStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[1][0],mySelf.selectDateArr[1][1],mySelf.selectDateArr[1][2]];
        NSDate *dateOut = [mySelf getDateFromString:dateOutStr];
        
        NSInteger liveOut = (NSInteger)[dateOut timeIntervalSince1970];
        
        mySelf.chooseDateView.dateIn.text = dateInStr;
        mySelf.chooseDateView.dateOut.text = dateOutStr;
        
        [mySelf.selectDateArr removeAllObjects];
        
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveIn]];
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveOut]];
        
        mySelf.chooseType = 1;
        
        [mySelf getSelectDate:mySelf.selectDateArr];
        
        [mySelf.tableView.mj_header beginRefreshing];
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseDateVC];
    
}

- (void)getSelectDate:(NSMutableArray *)selectDateArr
{
    self.tempChooseDateArr = [selectDateArr mutableCopy];
}

- (void)initTableView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.chooseDateView = [[FYChooseDateView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
    
    __weak typeof(self) mySelf = self;
    
    self.chooseDateView.chooseDateBlock = ^{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            mySelf.chooseDateVC.frame = CGRectMake(0, 0, mySelf.view.width, mySelf.view.height);
        }];
        
    };
    
    self.moreChoose = [[FYMoreChoose alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chooseDateView.frame), self.view.width, 40)];
    
    self.bothView = [[UIView alloc] initWithFrame:CGRectMake(0, NavH, self.view.width, self.chooseDateView.height + self.moreChoose.height)];
    self.bothView.backgroundColor = [UIColor whiteColor];
    
    [self.bothView addSubview:self.chooseDateView];
    
    [self.bothView addSubview:self.moreChoose];
    
    self.moreChoose.moreChooseBlock = ^(){
        
        FYMoreChooseVC *moreChooseVC = [[FYMoreChooseVC alloc] initWithNibName:@"FYMoreChooseVC" bundle:nil];
        
        moreChooseVC.view.frame = mySelf.view.bounds;
        
        moreChooseVC.returnMoreChooses = ^(NSInteger limitGuestsNum,NSInteger sex,NSMutableArray *spaceTypes,CGFloat startPrice,CGFloat endPrice,NSMutableArray *tempChooseDateArr,NSString *dateIn,NSString *dateOut){
        
            mySelf.chooseDateView.dateIn.text = dateIn;
            mySelf.chooseDateView.dateOut.text = dateOut;
            
            mySelf.sex = sex;
            mySelf.limitGuestsNum = limitGuestsNum;
            mySelf.spaceTypes = spaceTypes;
            mySelf.startPrice = startPrice;
            mySelf.endPrice = endPrice;
            mySelf.chooseType = 2;
            [mySelf getSelectDate:tempChooseDateArr];
            
            [mySelf.tableView.mj_header beginRefreshing];
        };
        
        [mySelf.navigationController pushViewController:moreChooseVC animated:YES];
        
    };
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH, self.view.width, self.view.height - NavH) style:UITableViewStylePlain];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.bothView.height, 0, 0, 0);
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
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
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FYCityHouseListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"houseCell"];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.bothView];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)downRefresh
{
    
    self.page = 1;
    
    NSString *url = nil;
    
    if (self.chooseType == 1) {
        
        url = [self getURLStrWithPage:self.page DateIn:self.tempChooseDateArr[0] DateOut:self.tempChooseDateArr[1]];
        
    }else if (self.chooseType == 2)
    {
        url = [self getURLWith:self.limitGuestsNum :self.tempChooseDateArr[1] :self.page :self.spaceTypes :self.sex :self.tempChooseDateArr[0] :self.startPrice :self.endPrice];
    }

    
    [self.manager GET:url parameters:nil success:^(id responseObject) {
        
        [self.tableView.mj_footer resetNoMoreData];
        self.tableView.mj_footer.hidden = NO;
        
        self.hasNext = [self getHasNext:responseObject];
        
        NSArray *cityHouseArr = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
        
        self.cityHouseArr = [FYCityHouseListData mj_objectArrayWithKeyValuesArray:cityHouseArr];
        
        [self isHiddenFooter];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];
    
}

- (void)upRefresh
{
    
    if (!self.hasNext) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
        __weak typeof(self) mySelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5f animations:^{
                
                mySelf.tableView.mj_footer.hidden = YES;
            }];
            
        });
        
        return;
    }
    
    self.page++;
    
    NSString *url = nil;
    
    if (self.chooseType == 1) {
        
        url = [self getURLStrWithPage:self.page DateIn:self.tempChooseDateArr[0] DateOut:self.tempChooseDateArr[1]];
        
    }else if (self.chooseType == 2)
    {
        url = [self getURLWith:self.limitGuestsNum :self.tempChooseDateArr[1] :self.page :self.spaceTypes :self.sex :self.tempChooseDateArr[0] :self.startPrice :self.endPrice];
    }
    
    [self.manager GET:url parameters:nil success:^(id responseObject) {
        
        self.hasNext = [self getHasNext:responseObject];;
        
        NSArray *cityHouseArr = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
        
        NSArray *newCityHouseArr = [FYCityHouseListData mj_objectArrayWithKeyValuesArray:cityHouseArr];
        
        [self.cityHouseArr addObjectsFromArray:newCityHouseArr];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];
}

- (NSString *)getURLStrWithPage:(NSInteger)page DateIn:(NSNumber *)dateIn DateOut:(NSNumber *)dateOut
{
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%ld,\n\"limitGuestsNum\":0,\n\"checkOutDate\":%ld,\n\"page\":%ld,\n\"userToken\":\"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3\",\n\"sex\":0,\n\"districtId\":0,\n\"checkInDate\":%ld}",self.cityId.integerValue,dateOut.integerValue,page,(long)dateIn.integerValue];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceByCity.do?";
    
    return [urlStr encodeURLWithParams:params];
}

- (NSString *)getURLWith:(NSInteger)limitNum :(NSNumber *)checkOutDate :(NSInteger)page :(NSArray *)spaceTypes :(NSInteger)sex :(NSNumber *)checkInDate :(CGFloat)startPrice :(CGFloat)endPrice
{

    
//    {
//        "cityId" : 73,
//        "limitGuestsNum" : 1,
//        "checkOutDate" : 1464969600000,
//        "checkInDate" : 1464710400000,
//        "page" : 1,
//        "startPrice" : "0",
//        "spaceTypes" : [
//                        "3",
//                        "1",
//                        "2"
//                        ],
//        "userToken" : "NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4",
//        "sex" : 1,
//        "districtId" : 0,
//        "endPrice" : "169.9"
//    }
    
//    http://www.shafalvxing.com/space/getSharedSpaceByCity.do?bizParams=%7B%0A%20%20%22cityId%22%20%3A%2073%2C%0A%20%20%22limitGuestsNum%22%20%3A%201%2C%0A%20%20%22checkOutDate%22%20%3A%201464969600000%2C%0A%20%20%22checkInDate%22%20%3A%201464710400000%2C%0A%20%20%22page%22%20%3A%201%2C%0A%20%20%22startPrice%22%20%3A%20%220%22%2C%0A%20%20%22spaceTypes%22%20%3A%20%5B%0A%20%20%20%20%223%22%2C%0A%20%20%20%20%221%22%2C%0A%20%20%20%20%222%22%0A%20%20%5D%2C%0A%20%20%22userToken%22%20%3A%20%22NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4%22%2C%0A%20%20%22sex%22%20%3A%201%2C%0A%20%20%22districtId%22%20%3A%200%2C%0A%20%20%22endPrice%22%20%3A%20%22169.9%22%0A%7D
    
//    http://www.shafalvxing.com/space/getSharedSpaceByCity.do?bizParams=%7B%0A%22cityId%22:73,%0A%22limitGuestsNum%22:1,%0A%22checkOutDate%22:0,%0A%22checkInDate%22:0,%0A%22page%22:1,%0A%22startPrice%22:0.000000,%0A%22spaceTypes%22:(%0A%20%20%20%201%0A),%0A%22userToken%22:%22NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4%22,%0A%22sex%22:1,%0A%22districtId%22:0,%0A%22endPrice%22:149.645808%7D
    
    
    
//    NSLog(@"最高价格:%f",endPrice);
    
    
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%ld,\n\"limitGuestsNum\":%ld,\n\"checkOutDate\":%ld,\n\"checkInDate\":%ld,\n\"page\":%ld,\n\"startPrice\":%f,\n\"spaceTypes\":%@,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\",\n\"sex\":%ld,\n\"districtId\":0,\n\"endPrice\":%f}",self.cityId.integerValue,limitNum,checkOutDate.integerValue,(long)checkInDate.integerValue,page,startPrice,spaceTypes.mj_JSONString,sex,endPrice];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceByCity.do?";
    
//    NSLog(@"url : %@",[urlStr encodeURLWithParams:params]);
    
    return [urlStr encodeURLWithParams:params];
}

//- (void)requestData
//{
//    NSString *url = nil;
//    
//    if (self.chooseType == 1) {
//        
//        url = [self getURLStrWithPage:self.page DateIn:self.selectDateArr[0] DateOut:self.selectDateArr[1]];
//    }else if (self.chooseType == 2)
//    {
//        url = [self getURLWith:self.limitGuestsNum :self.selectDateArr[1] :self.page :self.spaceTypes :self.sex :self.selectDateArr[0] :self.startPrice :self.endPrice];
//    }
//
//    [self.manager GET:url parameters:nil success:^(id responseObject) {
//        
//        self.hasNext = [self getHasNext:responseObject];
//        
//        NSArray *cityHouseArr = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
//        
//        self.cityHouseArr = [FYCityHouseListData mj_objectArrayWithKeyValuesArray:cityHouseArr];
//        
//        [self isHiddenFooter];
//        
//        [self.tableView reloadData];
//        
//        
//    } failur:^(NSError *error) {
//        
//        CYLog(@"error : %@",error);
//        
//    }];
//    
//    
//}

- (NSInteger)getHasNext:(id)responseObject
{
    NSString *hasNext = [[responseObject objectForKey:@"data"] objectForKey:@"hasNext"];
    
    return hasNext.integerValue;
}

- (void)isHiddenFooter
{
    if (self.cityHouseArr.count < 2) {
        
        if (!self.hasNext) {
            
            self.tableView.mj_footer.hidden = YES;
        }
    }
}

//切换到地图模式
- (void)swithToMapStyle
{
    FYCityHouseMapVC *mapVC = [[FYCityHouseMapVC alloc] init];
    
    mapVC.cityId = self.cityId;
    mapVC.cityName = self.cityName;
    
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

#pragma mark -- UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.tableView.contentOffset.y > -self.bothView.height) {
        
        [self.bothView removeFromSuperview];
        self.bothView.y = -self.bothView.height;
        [self.tableView addSubview:self.bothView];
        
    }
    
    if (self.tableView.contentOffset.y > -self.moreChoose.height)
    {
        [self.moreChoose removeFromSuperview];
        self.moreChoose.y = NavH;
        [self.view addSubview:self.moreChoose];
    }
    
    if (self.tableView.contentOffset.y < -self.bothView.height) {
        
        [self.bothView removeFromSuperview];
        self.bothView.y = NavH;
        [self.view addSubview:self.bothView];
        
    }
    
    if (self.tableView.contentOffset.y < -self.moreChoose.height) {
        
        [self.moreChoose removeFromSuperview];
        self.moreChoose.y = self.chooseDateView.height;
        [self.bothView addSubview:self.moreChoose];
    }
 

}

//cityId的setter方法
- (void)setCityId:(NSString *)cityId
{
    _cityId = cityId;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"你的内存快爆了!");
    
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
}


@end
