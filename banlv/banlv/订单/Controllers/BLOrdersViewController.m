//
//  BLOrdersViewController.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLOrdersViewController.h"

@interface BLOrdersViewController ()

@property (weak, nonatomic) IBOutlet UIButton *currentOrder;
@property (weak, nonatomic) IBOutlet UIButton *historyOrder;
@property(nonatomic, strong) CALayer *layerLine;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentSizeOfW;
@property (weak, nonatomic) IBOutlet UITableView *currentTableView;

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentTableViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyTableViewL;
@end

@implementation BLOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = kScreenFrame;
    self.navigationItem.title = @"订单";
    
    self.currentOrder.selected = YES;
    
    self.layerLine = [[CALayer alloc] init];
    
    self.layerLine.frame = CGRectMake(0, CGRectGetMaxY(self.currentOrder.frame) - 2, self.currentOrder.width, 2);
    self.layerLine.backgroundColor = [UIColor colorWithHexString:@"#4FB8BB"].CGColor;
    
    [self.view.layer addSublayer:self.layerLine];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width * 2, self.view.height - CGRectGetMaxY(self.currentOrder.frame));
    
    [self.currentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"currentCell"];
    
    [self.historyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"historyCell"];
    
}


- (IBAction)currentOrderClick:(id)sender {
    
    if (self.currentOrder.selected) {
        
        return;
    }
    
    self.currentOrder.selected = !self.currentOrder.isSelected;
    
    self.historyOrder.selected = NO;
    
    self.layerLine.frame = CGRectMake(0, self.layerLine.frame.origin.y, self.layerLine.frame.size.width, 2);
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)historyOrderClick:(id)sender {
    
    if (self.historyOrder.selected) {
        
        return;
    }
    
    self.historyOrder.selected = !self.historyOrder.isSelected;
    
    self.currentOrder.selected = NO;
    
    self.layerLine.frame = CGRectMake(self.layerLine.frame.size.width, self.layerLine.frame.origin.y, self.layerLine.frame.size.width, 2);
    
    [self.scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:YES];
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    if (tableView == self.currentTableView) {
       
        cell = [tableView dequeueReusableCellWithIdentifier:@"currentCell"];
        
    }else if (tableView == self.historyTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    }
    
    return cell;
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.scrollView.contentOffset.x == 0) {
        
        self.currentOrder.selected = YES;
        self.historyOrder.selected = NO;
        
        self.layerLine.frame = CGRectMake(0, self.layerLine.frame.origin.y, self.layerLine.frame.size.width, 2);
    }
    else if (self.scrollView.contentOffset.x == self.view.width)
    {
        self.historyOrder.selected = YES;
        self.currentOrder.selected = NO;
        
        self.layerLine.frame = CGRectMake(self.layerLine.frame.size.width, self.layerLine.frame.origin.y, self.layerLine.frame.size.width, 2);
    }
    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.scrollViewContentSizeOfW.constant = self.view.width * 2;
    
    self.currentTableViewW.constant = self.view.width;
    
    self.historyTableViewL.constant = self.view.width;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
