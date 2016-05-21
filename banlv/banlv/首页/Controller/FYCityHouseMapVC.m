//
//  FYCityHouseMapVC.m
//  banlv
//
//  Created by lfy on 16/5/17.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseMapVC.h"

//用的列表模式模型（地图模式模型数据一样）
#import "FYCityHouseListData.h"

//大头针的数据模型
#import "FYCityHouseMapData.h"

//cell模型
#import "FYCityHouseMapCell.h"


@interface FYCityHouseMapVC () <BMKMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) BMKMapView *mapView;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray<FYCityHouseMapData *> *pinArr;

//存放模型的数组
@property(nonatomic,strong) NSArray<FYCityHouseListData *> *cityHouseArr;

@end

@implementation FYCityHouseMapVC

- (NSMutableArray<FYCityHouseMapData *> *)pinArr
{
    if (!_pinArr) {
        
        _pinArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _pinArr;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.cityName;

    [self initMap];
    
    [self initCollectionView];
    
    [self requestData];
    
    
}

- (void)initMap
{
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    
    self.mapView.zoomLevel = 11.9f;
    
    [self.view addSubview:self.mapView];
    
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.height - 160, self.view.width, 100) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FYCityHouseMapCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
    
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的item的索引为:%ld",indexPath.row);
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.cityHouseArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FYCityHouseMapCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cityHouseData = self.cityHouseArr[indexPath.row];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.width, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (void)insertPinWithLat:(CLLocationDegrees)lat Lng:(CLLocationDegrees)lng Price:(NSString *)price Index:(NSString *)index;
{
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lng;
    annotation.coordinate = coor;
    
    annotation.title = [NSString stringWithFormat:@"¥%.1f",price.floatValue];
    annotation.subtitle = index;
    
    [_mapView addAnnotation:annotation];
}

- (void)requestData
{
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%@,\n\"limitGuestsNum\":0,\n\"checkOutDate\":0,\n\"districtId\":0,\n\"sex\":0,\n\"sex\":0,\n\"checkInDate\":0,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"\n}",self.cityId];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSpaceByLatLng.do?";
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
        NSArray *cityHouseArr = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
        
        
        //大头针的模型数组
        self.pinArr = [FYCityHouseMapData mj_objectArrayWithKeyValuesArray:cityHouseArr];
        
        //设置地图中心点
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.pinArr[0].lat.doubleValue, self.pinArr[0].lng.doubleValue) animated:NO];
        
        [self.pinArr enumerateObjectsUsingBlock:^(FYCityHouseMapData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self insertPinWithLat:obj.lat.doubleValue Lng:obj.lng.doubleValue Price:obj.price Index:[NSString stringWithFormat:@"%lu",idx]];
            
        }];
        
        //collection的cell模型数组
        self.cityHouseArr = [FYCityHouseListData mj_objectArrayWithKeyValuesArray:cityHouseArr];
        
        [self.collectionView reloadData];
        
        
        
    } failur:^(NSError *error) {
       
        CYLog(@"error : %@",error);
    }];
}

#pragma mark -- BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        static NSString *identifier = @"myAnnotation";
        
        BMKPinAnnotationView *newAnnotationView = nil;
        
        newAnnotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!newAnnotationView) {
            
            newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 40, 15)];
        
        label.text = newAnnotationView.annotation.title;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:10.f];
        
        [newAnnotationView addSubview:label];
        
        return newAnnotationView;
        
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:view.annotation.subtitle.integerValue inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}

//setter方法
- (void)setCityId:(NSString *)cityId
{
    _cityId = cityId;
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
