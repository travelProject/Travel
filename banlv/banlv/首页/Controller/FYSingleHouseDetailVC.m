//
//  FYSingleHouseDetailVC.m
//  banlv
//
//  Created by lfy on 16/5/26.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSingleHouseDetailVC.h"

//轮播图
#import "FYCollectionHeader.h"

//房间数据模型
#import "FYSingleHouseDetailData.h"

typedef enum : NSUInteger {
    SpaceTypeLivingRoom = 1,
    SpaceTypeJointRent = 2,
    SpaceTypeSeparateHouse = 3,
} SpaceType;

@interface FYSingleHouseDetailVC () <BMKMapViewDelegate>

@property(nonatomic,strong)FYAFNetworkingManager *manager;
@property (weak, nonatomic) IBOutlet FYCollectionHeader *bannerPic;
@property (weak, nonatomic) IBOutlet UILabel *pageNumLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *houseTypeLab;
@property (weak, nonatomic) IBOutlet UIImageView *ownerPic;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *ownerIntroduceLab;
@property (weak, nonatomic) IBOutlet UILabel *sapceIntroduceLab;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewH;

@property (weak, nonatomic) IBOutlet UIButton *applyBooking;

@end

@implementation FYSingleHouseDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.alpha = 0.1f;
    
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.alpha = 1.0;
    
    self.mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.manager = [FYAFNetworkingManager manager];
    
    self.bannerPic.bannerType = 2;
    
    self.bannerPic.returnCurrentPageAndTotal = ^(NSString *page){
    
        self.pageNumLab.text = page;
    };
    
    self.ownerPic.layer.cornerRadius = 25.f;
    self.ownerPic.layer.masksToBounds = YES;
    
    self.mapView.zoomLevel = 11.9f;
    
    self.applyBooking.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    [self requestData];
    
}

- (void)requestData
{

    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"spaceId\":%@,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"}",self.spaceId];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceInfo.do?";
    
    [self.manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        NSArray *banner = [[responseObject objectForKey:@"data"] objectForKey:@"pictureList"];
        
        self.bannerPic.topPicArr = banner;
        
        FYSingleHouseDetailData *singlehouseData = [FYSingleHouseDetailData mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        
        self.priceLab.text = [NSString stringWithFormat:@"¥%.1f",singlehouseData.price.floatValue];
        self.titleLab.text = singlehouseData.title;
        
        //    spaceType;//房间类型（1.客厅沙发 2.合租房间 榻榻米 3.独立房间 双人床）
        switch (singlehouseData.spaceType.integerValue) {
                
            case SpaceTypeLivingRoom:
                
                self.houseTypeLab.text = @"客厅·沙发·";
                
                break;
                
            case SpaceTypeJointRent:
                
                self.houseTypeLab.text = @"合租房间·榻榻米·";
                
                break;
                
            case SpaceTypeSeparateHouse:
                
                self.houseTypeLab.text = @"独立房间·双人床·";
                
                break;
                
            default:
                
                break;
        }
        
        if ([singlehouseData.sexLimit isEqualToString:@"1"]) {
            
            self.houseTypeLab.text = [NSString stringWithFormat:@"%@男女不限",self.houseTypeLab.text];
        }
        
        [self.ownerPic sd_setImageWithURL:[NSURL URLWithString:singlehouseData.ownerPic] placeholderImage:nil];
        
        self.ownerNameLab.text = singlehouseData.ownerName;
        
        self.ageLab.text = [NSString stringWithFormat:@"%@岁",singlehouseData
                            .age];
        
        self.ownerIntroduceLab.text = [NSString stringWithFormat:@"  %@",singlehouseData.ownerDescription];
        
        self.sapceIntroduceLab.text = singlehouseData.descrip;
        
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(singlehouseData.lat.doubleValue, singlehouseData.lng.doubleValue) animated:NO];
        
        [self insertPinWithLat:singlehouseData.lat.doubleValue Lng:singlehouseData.lng.doubleValue Address:singlehouseData.address];
        
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
    }];
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
    
    [self.mapView addAnnotation:annotation];
}

#pragma mark -- BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKAnnotationView *newAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        
        newAnnotationView.image = [UIImage imageNamed:@"place"];
        
        return newAnnotationView;
        
    }
    return nil;
}

- (IBAction)applyBookingAct:(id)sender {
    
    NSLog(@"申请预定");
}

- (void)setSpaceId:(NSString *)spaceId
{
    _spaceId = spaceId;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.scrollViewH.constant = CGRectGetMaxY(self.mapView.frame);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
