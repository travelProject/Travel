//
//  CYBaomingViewController.m
//  banlv
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 llz. All rights reserved.
//

# define sixinH 50.f
#import "CYBaomingViewController.h"
#import "CYBMView.h"

@interface CYBaomingViewController ()

@property(nonatomic ,strong)CYBMView *baceView;

@end

@implementation CYBaomingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *Btn = [[UIButton alloc] init];
    Btn.frame = CGRectMake(0, kScreenFrameH - sixinH, kScreenFrameW, sixinH);
    Btn.backgroundColor = ThemeColor;
    [Btn setTitle:@"确认并支付" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:Btn];
    [self views];

}

- (void)views{
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  64, kScreenFrameW, kScreenFrameH - sixinH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    //    self.mainScrollView = mainScrollView;
    //    mainScrollView.delegate = self;
    
    //    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,474);
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    CYBMView *baceView = [[CYBMView alloc] init];
    baceView.frame = CGRectMake(0, 0, kScreenFrameW, 474);
    
    [baceView.weixin addTarget:self action:@selector(weixinAction:) forControlEvents:UIControlEventValueChanged];
    [baceView.zhifubao addTarget:self action:@selector(zhifubaoAction:) forControlEvents:UIControlEventValueChanged];
    baceView.title.text = self.myData.title;
    
    [mainScrollView addSubview:baceView];
    self.baceView = baceView;
    
    
    baceView.title.text = self.myData.title;
    baceView.price.text = [NSString stringWithFormat:@"¥%@/人",self.myData.price];
    baceView.space.text = [NSString stringWithFormat:@"%@ - %@",self.myData.cityName,self.myData.address];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    //HH:mm:ss
    //    NSString *dateLoca = self.dataArr[indexPath.row].startTime;
    
    NSTimeInterval time=[self.myData.startTime doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    
    NSString *timestr = [formatter stringFromDate:detaildate];
    
    NSString *endTime = self.myData.endTime;
    time=[endTime doubleValue];
    
    detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    
    NSString *timestr1 = [formatter stringFromDate:detaildate];
    
    baceView.time.text = [NSString stringWithFormat:@"%@ ~ %@",timestr,timestr1];
    
    
    baceView.toprice.text = baceView.price.text;
    

}


- (void)weixinAction:(id)sender{
    if (self.baceView.weixin .on== YES) {
        self.baceView.zhifubao.on = NO;
    }
    if (self.baceView.weixin.on == NO) {
        self.baceView.zhifubao.on = YES;
    }
    
    
    
    
}
- (void)zhifubaoAction:(id)sender{
    if (self.baceView.zhifubao .on== YES) {
        self.baceView.weixin.on = NO;
    }
    if (self.baceView.zhifubao.on == YES) {
        self.baceView.weixin.on = NO;
    }
    
}


@end
