//
//  CYDizhuTableView.m
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDizhuTableView.h"
#import "CYDizhuCell.h"

#import "CYDizCellChildViewController.h"


#import "CYDizhuResultData.h"

#import "FYCarouselPic.h"


@interface CYDizhuTableView ()<UITableViewDelegate ,UITableViewDataSource ,UIScrollViewDelegate>

@property(nonatomic, strong)NSMutableArray<CYDizhuResultData *> *dataArr;

@property(nonatomic ,strong)AFHTTPSessionManager *manager;

//当前页
@property(nonatomic,assign)NSInteger page;

//总页数
@property(nonatomic,assign)NSInteger totalPageNum;

@end

@implementation CYDizhuTableView

- (NSInteger)page
{
    if (!_page) {
        
        _page = 1;
    }
    
    return _page;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.manager = [AFHTTPSessionManager manager];
        
        [self requestData];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        header.stateLabel.textColor = [UIColor colorWithHexString:@"#676767"];
        header.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"##676767"];
        
        
        self.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
        footer.stateLabel.textColor = [UIColor colorWithHexString:@"##676767"];
        [footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
        footer.automaticallyHidden = NO;
        
        self.mj_footer = footer;


    }
    return self;
}


- (NSString *)getURLStrWithPage:(NSInteger)page
{
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"page\":%ld}",self.page];
    
    NSString *urlStr = @"http://www.shafalvxing.com/channel/getLocalServiceList.do?";
    
    return [urlStr encodeURLWithParams:params];
}

- (void)requestData
{
    
    [self.manager GET:[self getURLStrWithPage:self.page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        
        self.totalPageNum = [self getHasNext:responseObject];
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = NO;
        
        NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
        
        
        self.dataArr = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:jsonArr];
        [self isHiddenFooter];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)upRefresh{
    
//    NSLog(@"%ld",(long)self.totalPageNum);
    
    if (self.page > self.totalPageNum) {
        [self.mj_footer endRefreshingWithNoMoreData];
        
        __weak typeof(self) mySelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5f animations:^{
                
                mySelf.mj_footer.hidden = YES;
            }];
            
        });
        
        return;
    }
    
    self.page++;
    
    [self.manager GET:[self getURLStrWithPage:self.page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = NO;
        
        self.totalPageNum = [self getHasNext:responseObject];
        
        NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
        
        NSArray *newArr = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:jsonArr];
        
        [self.dataArr addObjectsFromArray:newArr];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    NSLog(@"page%ld",  self.dataArr.count);
    
}




- (void)downRefresh{
    self.page = 1;
    
    [self.manager GET:[self getURLStrWithPage:self.page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = NO;
        
        self.totalPageNum = [self getHasNext:responseObject];
        
        NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
        
        
        self.dataArr = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:jsonArr];
        [self isHiddenFooter];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



- (NSInteger)getHasNext:(id)responseObject
{
    NSString *hasNext = [[responseObject objectForKey:@"data"]objectForKey:@"totalPageNum"];
    
    return hasNext.integerValue;
}

- (void)isHiddenFooter
{
    if (self.dataArr.count < 2) {
        
        if (self.page>=self.totalPageNum) {
            
            self.mj_footer.hidden = YES;
        }
    }
}




#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  self.selectRowBlock(indexPath.row);
    
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  (kScreenFrameW + 10);
}


#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    
    return self.dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CYDizhuCell";
    
    CYDizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = kLoadViewWithNIB(indentifier);
    
    }
    
    NSString *uuu = self.dataArr[indexPath.row].pictureList[0];
    [cell.bgImg sd_setImageWithURL:[NSURL URLWithString:uuu]];
    
//    cell.bgImg.picArr = self.dataArr[indexPath.row].pictureList;
    
    NSString  *gender = nil;
    if ([self.dataArr[indexPath.row].sex isEqualToString:@"1"]) {
        gender = @"男";
    }else{
        gender =@"女";
    }
    
    NSString *jianjie = [NSString stringWithFormat:@"%@岁  %@  %@",self.dataArr[indexPath.row].age,gender,self.dataArr[indexPath.row].profession];
    
    cell.jianjie.text =jianjie;
    
    NSString *serve1 = nil;
    NSString *serve2 = nil;
    if (self.dataArr[indexPath.row].serviceNameList.count ==1) {
        serve1 =self.dataArr[indexPath.row].serviceNameList[0];
    }else if (self.dataArr[indexPath.row].serviceNameList.count ==2){
        serve1 =self.dataArr[indexPath.row].serviceNameList[0];
         serve2 = self.dataArr[indexPath.row].serviceNameList[1];
    }
    
    cell.serve1.text = serve1;
    
    cell.serve2.text = serve2;
    
    cell.jiage.text =[NSString stringWithFormat:@"%@/天·%@ ",self.dataArr[indexPath.row].price,self.dataArr[indexPath.row].cityName];
    cell.userName.text = self.dataArr[indexPath.row].ownerName;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.xuanfuH();
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.xuanfuS();
    
}

@end
