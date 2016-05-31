//
//  BLAboutUsView.m
//  banlv
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLAboutUsView.h"
@interface BLAboutUsView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_nameArr;
    NSArray *_detailArr;
}
@end
@implementation BLAboutUsView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *aboutUsView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.width, self.height))];
        aboutUsView.backgroundColor = [UIColor cyanColor];
        
        [self addSubview:aboutUsView];
        _nameArr = @[@"微信公众号",@"联系邮箱",@"联系电话"];
        _detailArr = @[@"沙发旅行",@"hello@shafalvxing.com",@"021-63360357"];
        aboutUsView.dataSource = self;
        aboutUsView.delegate = self;
    }
    
    return self;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
    }
    cell.textLabel.text = _nameArr[indexPath.row];
    cell.detailTextLabel.text = _detailArr[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
