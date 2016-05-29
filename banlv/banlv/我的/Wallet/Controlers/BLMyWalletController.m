//
//  BLMyWalletController.m
//  伴旅
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLMyWalletController.h"
#import "BLCashAccountView.h"
#import "BLCouponView.h"
#import "BLMoneyInOutController.h"
@interface BLMyWalletController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;

    
}
@property (nonatomic,strong) UISegmentedControl *segment;
@end

@implementation BLMyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSegment];
    [self setUpScrollView];
    [self setUpAccountView];
    [self setUpCouponView];
    
    
}
- (void)setUpSegment{
    self.segment = [[UISegmentedControl alloc] initWithFrame:(CGRectMake(0, 0, 160, 30))];
    [self.segment insertSegmentWithTitle:@"现金账户" atIndex:0 animated:YES];
    [self.segment insertSegmentWithTitle:@"优惠券" atIndex:1 animated:YES];
    self.segment.selectedSegmentIndex = 0;
    //    segment.backgroundColor = [UIColor colorWithHexString:@"#429d96"];
    self.segment.tintColor = ThemeColor;//tintColor属性很强大
    self.navigationItem.titleView = self.segment;
    [self.segment addTarget:self action:@selector(segmentSelected:) forControlEvents:(UIControlEventValueChanged)];
    
}
//在主页面上添加scrollView
- (void)setUpScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenFrameW, kScreenFrameH)];
    _scrollView.contentSize = CGSizeMake(kScreenFrameW *2,0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
}
//在scrollView左半部添加现金账户视图
- (void)setUpAccountView{
    BLCashAccountView *accountView = [BLCashAccountView loadNib];
    accountView.origin = CGPointMake(0,0);
    [accountView.inOutBtn addTarget:self action:@selector(inOutAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:accountView];
//    _accountView = accountView;
    
}
- (void)inOutAction:(id)sender{
    BLMoneyInOutController *inOut = [[BLMoneyInOutController alloc] init];
    [self.navigationController pushViewController:inOut animated:YES];
    
}
//在scrollView右半部添加优惠券视图
- (void)setUpCouponView{
    BLCouponView *couponView = [BLCouponView loadNib];
    couponView.origin = CGPointMake(kScreenFrameW,0);
    [_scrollView addSubview:couponView];


}
//拖动scrollView后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger pagNum = _scrollView.contentOffset.x/kScreenFrameW + 0.5;

    self.segment.selectedSegmentIndex = pagNum;
}

- (void)segmentSelected:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenFrameW *self.segment.selectedSegmentIndex, -64);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
