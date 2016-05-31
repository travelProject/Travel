//
//  BLSetTableView.m
//  banlv
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLSetTableView.h"
@interface BLSetTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *dataArr;

@end



@implementation BLSetTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *setTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.width, self.height))];
    
        setTableView.scrollEnabled = NO;
        [self addSubview:setTableView];
        _dataArr = @[@"关于我们",@"意见反馈",@"清除缓存",@"退出登录"];
        setTableView.dataSource = self;
        setTableView.delegate = self;
        
    }
    return self;
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        //设置cell的类型UITableViewCellStyleValue1
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        //设置右侧附件类型（箭头）
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.detailTextLabel.text = _dataArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"shoucang"];
    
    
    return cell;
}
#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectRowBlock(indexPath.row);
}


@end
