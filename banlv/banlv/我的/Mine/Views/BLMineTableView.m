//
//  BLMineTableView.m
//  banlv
//
//  Created by scjy on 16/5/22.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLMineTableView.h"
@interface BLMineTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *dataArr;
@end
@implementation BLMineTableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.width,self.height)) style:(UITableViewStylePlain)];
        self.tableView.scrollEnabled = NO;//不允许滑动
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.dataArr = @[@"我的钱包",@"我的房源",@"可租日期管理",@"我的收藏",@"分享给好友",@"设置"];
        [self addSubview:self.tableView];
        
    }
    return self;
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        //设置cell的类型UITableViewCellStyleValue1
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        //设置右侧附件类型（箭头）
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.detailTextLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:@"shoucang"];
    
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectRowBlock(indexPath.row);
}


@end
