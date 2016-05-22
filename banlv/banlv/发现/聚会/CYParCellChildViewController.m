//
//  CYParCellChildViewController.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.


# define sixinH 50.f

#import "CYParCellChildViewController.h"

#import "CYParCellChildData.h"

#import "CYFristView.h"
#import "CYSecondView.h"
#import "CYThirdView.h"
#import "CYFourthView.h"

@interface CYParCellChildViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)CYParCellChildData  *myData;





@end

@implementation CYParCellChildViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
//    NSLog(@"%@",self.myData.title);
    self.i = nil;
   
}


- (void)setI:(NSString *)i
{
        _i = i;
    
        [self request];
}

- (CYParCellChildData *)myData{
    if (!_myData) {
        _myData = [[CYParCellChildData alloc] init];
    }
    return _myData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self request];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"活动详情";
    
    
    
    UIButton *sixinBtn = [[UIButton alloc] init];
    sixinBtn.frame = CGRectMake(0, kScreenFrameH - sixinH, kScreenFrameW/2, sixinH);
    sixinBtn.backgroundColor = [UIColor whiteColor];
    [sixinBtn setTitle:@"私信" forState:UIControlStateNormal];
    [sixinBtn setTitleColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:sixinBtn];
    
    UIButton *baomingBtn = [[UIButton alloc] init];
    baomingBtn.frame = CGRectMake(kScreenFrameW/2, kScreenFrameH - sixinH, kScreenFrameW/2, sixinH);
    baomingBtn.backgroundColor = [UIColor colorWithRed:0.28 green:0.79 blue:0.78 alpha:1];
    [baomingBtn setTitle:@"报名" forState:UIControlStateNormal];
    [self.view addSubview:baomingBtn];

    
}


- (void)request{
//    三级页面：http://www.shafalvxing.com/party/getPartyDetail.do
//    bizParams：{
//          "partyId" : 32,
//          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2"
//    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSLog(@"%@".self.i);
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"partyId\":%@,\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\"}",self.i];
    
    NSString *urlStr = @"http://www.shafalvxing.com/party/getPartyDetail.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        NSArray *jsonArr =[responseObject objectForKey:@"data"];
//        NSLog(@"%@",jsonArr);
        
       CYParCellChildData *myData  = [CYParCellChildData  mj_objectWithKeyValues:jsonArr];
        
        self.myData = myData;
        
        [self setViews];
        
//
//        [self reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


    
}

- (void)setViews{
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - sixinH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    //    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
    //    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,4*50+44*6+400  +456);
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    CYFristView *view1 = [[CYFristView alloc] init];
    view1.frame = CGRectMake(0, -64, kScreenFrameW, 390);
    view1.lunbo.picArr  = self.myData.pics;
    view1.title.text = self.myData.title;
    view1.price.text = [NSString stringWithFormat:@"¥%@/人",self.myData.price];
    view1.dizhi.text = [NSString stringWithFormat:@"%@ - %@",self.myData.cityName,self.myData.address];
    [mainScrollView addSubview:view1];
    
    CYSecondView *view2 = [[CYSecondView alloc] init];
    
    NSString *s = self.myData.description1;
    //    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //    CGSize size = CGSizeMake(kScreenFrameW,2000);
    view2.deciption1.lineBreakMode = NSLineBreakByWordWrapping;
    view2.deciption1.text = s;
    //    view2.deciption1.font =font;
    CGSize size = [view2.deciption1 sizeThatFits:CGSizeMake(view2.deciption1.frame.size.width, MAXFLOAT)];
    view2.deciption1.size = CGSizeMake(size.width, size.height);
    
    
    view2.frame = CGRectMake(0, CGRectGetMaxY(view1.frame)+3, kScreenFrameW, 40 + view2.deciption1.size.height);
//    NSLog(@"%f",view2.frame.size.height);
    
    [mainScrollView addSubview:view2];
    
    CYThirdView *view3 = [[CYThirdView alloc] init];
    view3.frame = CGRectMake(0, CGRectGetMaxY(view2.frame)+3, kScreenFrameW, 187);
    view3.userName.text = self.myData.ownerName;
    
    NSString *uuu = self.myData.avatar;
    
    [view3.icon sd_setImageWithURL:[NSURL URLWithString: uuu]];
    NSString *iii = nil;
    if (self.myData.sex ==1) {
        iii = @"男";
    }else{
        iii = @"女";
    }
    
    
    
    view3.jianjie.text = [NSString stringWithFormat:@"%@岁 %@",self.myData.age,iii];
    [mainScrollView addSubview:view3];
    
    
    CYFourthView *view4 = [[CYFourthView alloc] init];
    view4.frame = CGRectMake(0, CGRectGetMaxY(view3.frame)+3, kScreenFrameW, 308);
    view4.joinCount.text = [NSString stringWithFormat:@"%@人参加",self.myData.joinUserCount];
    [mainScrollView addSubview:view4];
    
    
//    NSLog(@"%@",self.myData.title);
//    NSLog(@"%@",view1.title.text);

}

@end
