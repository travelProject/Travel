//
//  CYPoViewController.m
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//
# define poBtnH 50.f
# define jiange 20.f

#import "CYPoViewController.h"
#import "CYPoHeaderView.h"
#import "FYLookMoreCityVC.h"
#import "ZFChooseTimeViewController.h"


@interface CYPoViewController ()<UIScrollViewDelegate>


@property(nonatomic ,copy)NSString *cityId;

@property(nonatomic ,copy)NSString *cityName;

@property(nonatomic ,strong)FYLookMoreCityVC *VCNew;

@property(nonatomic ,strong)ZFChooseTimeViewController *shijian1 ;
@property(nonatomic ,strong)NSMutableArray *selectDateArr;

@property(nonatomic ,strong)UIButton *btn5;

@property(nonatomic ,strong)UIButton *btn1;

@property(nonatomic ,strong)UIButton *btn2;


@end

@implementation CYPoViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    self.title = @"发布";
    [self request];
   
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - 64, kScreenFrameW, kScreenFrameH - poBtnH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
//    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
//    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,4*jiange+44*6+400  );
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    
    
    
    CYPoHeaderView *CYHeader = [[CYPoHeaderView alloc] init];
    
    CYHeader.frame = CGRectMake(0, 0, kScreenFrameW, 400);
    
    [mainScrollView addSubview:CYHeader];
    
    UIButton *poBtn = [[UIButton alloc] init];
    poBtn.frame = CGRectMake(0, kScreenFrameH - poBtnH, kScreenFrameW, poBtnH);
    poBtn.backgroundColor = ThemeColor;
    [poBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.view addSubview:poBtn];
    
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, CYHeader.size.height + jiange, kScreenFrameW, 44);
    
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    
    UILabel *left1 = [[UILabel alloc] init];
    
    left1.frame = CGRectMake(8, 3, 80, 38);
    
    left1.text = @"开始时间";
    
    [view1 addSubview:left1];
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.frame = CGRectMake(kScreenFrameW - 138, 3, 130, 38);
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"请设置" forState:UIControlStateNormal];
    btn1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    [btn1 addTarget:self action:@selector(startTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn1];
    self.btn1 = btn1;
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(0, view1.origin.y + 44 , kScreenFrameW, 44);
    view2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view2];
    UILabel *left2 = [[UILabel alloc] init];
    
    left2.frame = CGRectMake(8, 3, 80, 38);
    
    left2.text = @"结束时间";
    
    [view2 addSubview:left2];
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.frame = CGRectMake(kScreenFrameW - 138, 3, 130, 38);
//    btn2.titleLabel.textAlignment = NSTextAlignmentRight;
    btn2.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    [btn2 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(endTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"请设置" forState:UIControlStateNormal];
    [view2 addSubview:btn2];
    self.btn2 = btn2;
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(0, view2.origin.y + 44 +jiange , kScreenFrameW, 44);
    view3.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view3];
    UILabel *left3 = [[UILabel alloc] init];
    
    left3.frame = CGRectMake(8, 3, 80, 38);
    
    left3.text = @"活动价格";
    
    [view3 addSubview:left3];
    UITextField *tf3 = [[UITextField alloc] init];
    tf3.frame = CGRectMake(kScreenFrameW - 100, 3, 100, 38);
    tf3.placeholder = @"请输入价格";
    [view3 addSubview:tf3];

    
    
    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(0, view3.origin.y + 44 , kScreenFrameW, 44);
    view4.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view4];
    UILabel *left4 = [[UILabel alloc] init];
    
    left4.frame = CGRectMake(8, 3, 80, 38);
    
    left4.text = @"人数限制";
    
    [view4 addSubview:left4];
    UITextField *tf4 = [[UITextField alloc] init];
    tf4.frame = CGRectMake(kScreenFrameW - 120, 3, 120, 38);
    tf4.placeholder = @"请输入最高人数";
    [view4 addSubview:tf4];
    
    
    UIView *view5 = [[UIView alloc] init];
    view5.frame = CGRectMake(0, view4.origin.y + 44 +jiange , kScreenFrameW, 44);
    view5.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view5];
    UILabel *left5 = [[UILabel alloc] init];
    
    left5.frame = CGRectMake(8, 3, 80, 38);
    
    left5.text = @"活动地址";
    
    [view5 addSubview:left5];
    UIButton *btn5 = [[UIButton alloc] init];
    btn5.frame = CGRectMake(kScreenFrameW - 58, 3, 50, 38);
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(dizhiAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setTitle:@"设置" forState:UIControlStateNormal];
    [view5 addSubview:btn5];
    self.btn5 = btn5;

    
    
    UIView *view6 = [[UIView alloc] init];
    view6.frame = CGRectMake(0, view5.origin.y + 44 +jiange , kScreenFrameW, 44);
    view6.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view6];
    UILabel *left6 = [[UILabel alloc] init];
    
    left6.frame = CGRectMake(8, 3, 80, 38);
    
    left6.text = @"实名认证";
    
    [view6 addSubview:left6];
    UIButton *btn6 = [[UIButton alloc] init];
    btn6.frame = CGRectMake(kScreenFrameW - 88, 3, 80, 38);
    
    [btn6 setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn6 setTitle:@"立即认证" forState:UIControlStateNormal];
    [view6 addSubview:btn6];
    
    
    ZFChooseTimeViewController *shijian1 = [[ZFChooseTimeViewController alloc] init];
    shijian1.frame = CGRectMake(0, kScreenFrameH, kScreenFrameW, kScreenFrameH);
    
    [[UIApplication sharedApplication].keyWindow addSubview:shijian1];
    self.shijian1 = shijian1;
    
    __weak typeof(self) mySelf = self;
    
    self.shijian1.returnDateBlock = ^(NSMutableArray *selectedDateArr)
    {
        mySelf.selectDateArr = selectedDateArr;
        
        if (selectedDateArr) {
            [mySelf updateTime];
        }
        
        
        
    };
    

    
    

}
- (void)updateTime{
  
    
    NSString *b1 = (NSString *)self.selectDateArr[0][0];
     NSString *b2 = (NSString *)self.selectDateArr[0][1];
     NSString *b3 = (NSString *)self.selectDateArr[0][2];
    NSString *bb = [NSString stringWithFormat:@"%@-%@-%@",b1,b2,b3];
    
    [self.btn1 setTitle:bb forState:UIControlStateNormal];
    
    NSString *c1 = (NSString *)self.selectDateArr[1][0];
    NSString *c2 = (NSString *)self.selectDateArr[1][1];
    NSString *c3 = (NSString *)self.selectDateArr[1][2];
    NSString *cb = [NSString stringWithFormat:@"%@-%@-%@",c1,c2,c3];
    
    [self.btn2 setTitle:cb forState:UIControlStateNormal];
    
}

- (void)request{
//    
//http://www.shafalvxing.com/endUser/getUserIdentificationStatus.do
//    bizParams：{
//          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2"
//    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    NSLog(@"%@".self.i);
//    self.i = @"262";
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\""];
    
    NSString *urlStr = @"http://www.shafalvxing.com/endUser/getUserIdentificationStatus.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        //        NSArray *jsonArr =[responseObject objectForKey:@"data"];
        
        //        CYParCellChildData *myData  = [CYParCellChildData  mj_objectWithKeyValues:jsonArr];
        //
        //        self.myData = myData;
        //        [self addIfo];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)startTimeAction:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.shijian1.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH);
    }];
    
    
    
    
}
- (void)endTimeAction:(id)sender{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.shijian1.frame = CGRectMake(0, 0, kScreenFrameW, kScreenFrameH);
    }];
    
}
- (void)dizhiAction:(id)sender{
    
    
    FYLookMoreCityVC *new = [[FYLookMoreCityVC alloc] init];
    [self.navigationController pushViewController:new animated:YES];
    new.selectedIdBlock = ^(NSString *cityId,NSString *cityName){
        
        self.cityId = cityId;
        
        self.cityName = cityName;
    };
    
    self.VCNew = new;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    

    
    if (self.VCNew) {
//        NSLog(@"%@",self.cityName);
        
        
        [self.btn5 setTitle:self.cityName forState:UIControlStateNormal];
        
    }
    
    
    
}
@end
