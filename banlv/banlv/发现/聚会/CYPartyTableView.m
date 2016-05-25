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

@property(nonatomic ,strong)NSMutableArray<CYPartyCellData *> *dataArr;

@property(nonatomic ,strong)AFHTTPSessionManager *manager;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSInteger hasNext;

@end

@implementation CYPartyTableView


- (NSInteger)page
{
    if (!_page) {
        
        _page = 1;
    }
    
    return _page;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr  = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
            self.dataSource = self;
        self.backgroundColor = ThemeColor;
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
    
//    NSLog(@"点击了%@",self.dataArr[indexPath.row].partyId);
    

        
        self.partyIdBlock(self.dataArr[indexPath.row].partyId);
        
        
        
        
        
    
}


- (NSString *)getURLStrWithPage:(NSInteger)page
{
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\",\n\"page\":%ld}",self.page];
    
    NSString *urlStr = @"http://www.shafalvxing.com/party/queryPartyWithPage.do?";
    
    return [urlStr encodeURLWithParams:params];
}


- (void)requestData
{
    
    [self.manager GET:[self getURLStrWithPage:self.page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = NO;
        
        self.hasNext = [self getHasNext:responseObject];
        
        NSArray *jsonArr = [[[responseObject objectForKey:@"data"]objectForKey:@"parties" ] objectForKey:@"result"];
        
        self.dataArr = [CYPartyCellData mj_objectArrayWithKeyValuesArray:jsonArr];
        [self isHiddenFooter];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)upRefresh{
    
    if (!self.hasNext) {
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
        
        self.hasNext = [self getHasNext:responseObject];
        
        NSArray *jsonArr = [[[responseObject objectForKey:@"data"]objectForKey:@"parties" ] objectForKey:@"result"];
        
        NSArray *newArr = [CYPartyCellData mj_objectArrayWithKeyValuesArray:jsonArr];
        
        [self.dataArr addObjectsFromArray:newArr];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}




- (void)downRefresh{
    self.page = 1;
    
    [self.manager GET:[self getURLStrWithPage:self.page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.mj_footer resetNoMoreData];
        self.mj_footer.hidden = NO;
        
        self.hasNext = [self getHasNext:responseObject];
        
        NSArray *jsonArr = [[[responseObject objectForKey:@"data"]objectForKey:@"parties" ] objectForKey:@"result"];
        
       self.dataArr = [CYPartyCellData mj_objectArrayWithKeyValuesArray:jsonArr];
        [self isHiddenFooter];
        
        [self reloadData];
        
        [self.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



- (NSInteger)getHasNext:(id)responseObject
{
    NSString *hasNext = [[[responseObject objectForKey:@"data"]objectForKey:@"parties" ] objectForKey:@"hasNext"];
    
    return hasNext.integerValue;
}

- (void)isHiddenFooter
{
    if (self.dataArr.count < 1) {
        
        if (!self.hasNext) {
            
            self.mj_footer.hidden = YES;
        }
    }
}


@end
