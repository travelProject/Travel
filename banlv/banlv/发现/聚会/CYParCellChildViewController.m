//
//  CYParCellChildViewController.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.


# define sixinH 50.f

#import "CYViewPageView.h"
#import "CYBaomingViewController.h"

#import "CYParCellChildViewController.h"

#import "CYParCellChildData.h"

#import "CYFristView.h"
#import "CYSecondView.h"
#import "CYThirdView.h"
#import "CYFourthView.h"

@interface CYParCellChildViewController ()<UIScrollViewDelegate,CYViewPagerDelegate>

@property (nonatomic ,strong)CYParCellChildData  *myData;
@property(nonatomic, strong)CYFristView *view1;
@property(nonatomic, strong)CYSecondView *view2;

@property(nonatomic, strong)CYThirdView *view3;

@property(nonatomic, strong)CYFourthView *view4;

@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong)UIScrollView *mainScrollView;


@end

@implementation CYParCellChildViewController


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

        if (self.mainScrollView.contentOffset.y < 280){
        
        self.barView.hidden = NO;
        self.barView.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f  alpha:self.mainScrollView.contentOffset.y / 500 + 0.01];
        
    }else{
        
        self.barView.hidden = NO;
        self.barView.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.barView = self.navigationController.navigationBar;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
//    NSLog(@"%@",self.myData.title);
    
   
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
    [self setViews];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"活动详情";
        
    UIButton *sixinBtn = [[UIButton alloc] init];
    sixinBtn.frame = CGRectMake(0, kScreenFrameH - sixinH, kScreenFrameW/2, sixinH);
    sixinBtn.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [sixinBtn setTitle:@"私信" forState:UIControlStateNormal];
    [sixinBtn setTitleColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:sixinBtn];
    
    UIButton *baomingBtn = [[UIButton alloc] init];
    baomingBtn.frame = CGRectMake(kScreenFrameW/2, kScreenFrameH - sixinH, kScreenFrameW/2, sixinH);
    baomingBtn.backgroundColor = [UIColor colorWithRed:0.28 green:0.79 blue:0.78 alpha:1];
    [baomingBtn addTarget:self action:@selector(baomingAction:) forControlEvents:UIControlEventTouchUpInside];
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
//        NSLog(@"%@",[urlStr encodeURLWithParams:params] );
        NSArray *jsonArr =[responseObject objectForKey:@"data"];
        
       CYParCellChildData *myData  = [CYParCellChildData  mj_objectWithKeyValues:jsonArr];
        
        self.myData = myData;
        [self addIfo];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)setViews{
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, kScreenFrameW, kScreenFrameH - sixinH+64)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    //    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    
    //    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.contentSize = CGSizeMake(kScreenFrameW ,4*50+44*6+400+80+456);
    
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    CYFristView *view1 = [[CYFristView alloc] init];
   
    
    
    [mainScrollView addSubview:view1];
    self.view1 = view1;
    
    CYSecondView *view2 = [[CYSecondView alloc] init];
    
    [mainScrollView addSubview:view2];
    self.view2 = view2;
    
    CYThirdView *view3 = [[CYThirdView alloc] init];
    
    [mainScrollView addSubview:view3];
    self.view3 = view3;
    
    CYFourthView *view4 = [[CYFourthView alloc] init];
    
    [mainScrollView addSubview:view4];
    self.view4 = view4;
    
    self.mainScrollView = mainScrollView;
    
}


- (void)addIfo{
    self.view1.frame = CGRectMake(0, -64, kScreenFrameW, 470);
    

    CYViewPageView *pageview = [[CYViewPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, 360)];
    pageview.delegate = self;
    pageview.imageAry = self.myData.pics ;
    [self.view1.lunbo addSubview:pageview];

    
    self.view1.title.text = self.myData.title;
    self.view1.price.text = [NSString stringWithFormat:@"¥%@/人",self.myData.price];
    self.view1.dizhi.text = [NSString stringWithFormat:@"%@ - %@",self.myData.cityName,self.myData.address];
    
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
    
    self.view1.time.text = [NSString stringWithFormat:@"%@ ~ %@",timestr,timestr1];

    NSString *s = self.myData.description1;
    
    self.view2.deciption1.text = s;
 
    self.view2.origin = CGPointMake(0, CGRectGetMaxY(self.view1.frame)+3);
    
    
    
//    self.view2.deciption1.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view2.deciption1 sizeToFit];
//    CGSize size1 = [self.view2.deciption1 sizeThatFits:CGSizeMake(kScreenFrameW, MAXFLOAT)];
    
//    self.view2.size = CGSizeMake(kScreenFrameW, 40 + size1.height);
    
    self.view3.frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame)+3, kScreenFrameW, 187);
    self.view3.userName.text = self.myData.ownerName;
    
    NSString *uuu = self.myData.avatar;
    
    [self.view3.icon sd_setImageWithURL:[NSURL URLWithString: uuu]];
    NSString *iii = nil;
    if (self.myData.sex ==1) {
        iii = @"男";
    }else{
        iii = @"女";
    }
    
    self.view3.jianjie.text = [NSString stringWithFormat:@"%@岁 %@",self.myData.age,iii];
    
    self.view4.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame)+3, kScreenFrameW, 308);
    self.view4.joinCount.text = [NSString stringWithFormat:@"%@人参加",self.myData.joinUserCount];
    
    [self.view4.map setCenterCoordinate:CLLocationCoordinate2DMake(self.myData.lat, self.myData.lng) animated:NO];
    
    [self insertPinWithLat:self.myData.lat Lng:self.myData.lng Address:self.myData.address];
    
}

- (void)insertPinWithLat:(CLLocationDegrees)lat Lng:(CLLocationDegrees)lng Address:(NSString *)address;
{
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lng;
    annotation.coordinate = coor;
    
    annotation.title = address;
    
    [self.view4.map addAnnotation:annotation];
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKAnnotationView *newAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        
        newAnnotationView.image = [UIImage imageNamed:@"dizhi"];
        
        return newAnnotationView;
        
    }
    return nil;
}

- (void)baomingAction:(id)sender{
    CYBaomingViewController *new = [[CYBaomingViewController alloc] init];
    __weak typeof(self) mySelf = self;
    new.myData = mySelf.myData;
    [self.navigationController pushViewController:new animated:YES];
    
}


- (void)didViewPagerViewClick:(NSInteger)tag{
    
}


@end
