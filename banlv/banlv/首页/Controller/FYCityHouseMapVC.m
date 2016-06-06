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

//选择日期的View
#import "FYChooseDateView.h"

//更多选择
#import "FYMoreChoose.h"

//筛选条件控制器
#import "FYMoreChooseVC.h"

//房间详细信息类
#import "FYSingleHouseDetailVC.h"


@interface FYCityHouseMapVC () <BMKMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) FYChooseDateView *chooseDateView;

@property(nonatomic,strong) FYMoreChoose *moreChoose;

@property(nonatomic,strong) BMKMapView *mapView;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray<FYCityHouseMapData *> *pinArr;

//存放模型的数组
@property(nonatomic,strong) NSArray<FYCityHouseListData *> *cityHouseArr;

@property(nonatomic,strong)BMKAnnotationView *lastAnnoView;

@property(nonatomic,strong)ZFChooseTimeViewController *chooseDateVC;

@property(nonatomic,strong) FYAFNetworkingManager *manager;

@end

@implementation FYCityHouseMapVC

- (NSMutableArray<FYCityHouseMapData *> *)pinArr
{
    if (!_pinArr) {
        
        _pinArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _pinArr;
}

- (NSInteger)limitGuestsNum
{
    if (!_limitGuestsNum) {
        
        _limitGuestsNum = 0;
    }
    
    return _limitGuestsNum;
}

- (NSMutableArray *)spaceTypes
{
    if (!_spaceTypes) {
        
        _spaceTypes = [NSMutableArray array];
    }
    
    return _spaceTypes;
}

- (NSInteger)sex
{
    if (!_sex) {
        
        _sex = 0;
    }
    
    return _sex;
}

- (NSInteger)chooseType
{
    if (!_chooseType) {
        
        _chooseType = 1;
    }
    
    return _chooseType;
}

- (CGFloat)startPrice
{
    if (!_startPrice) {
        
        _startPrice = 0.0;
    }
    
    return _startPrice;
}

- (CGFloat)endPrice
{
    if (!_endPrice) {
        
        _endPrice = 199.9;
    }
    
    return _endPrice;
}

- (NSMutableArray<BMKPointAnnotation *> *)annotationArr
{
    if (!_annotationArr) {
        
        _annotationArr = [NSMutableArray array];
    }
    
    return _annotationArr;
}

- (NSMutableArray *)selectDateArr
{
    if (!_selectDateArr) {
        
        _selectDateArr = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    }
    
    return _selectDateArr;
}

- (NSDate *)getDateFromString:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return [format dateFromString:dateStr];
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
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"lookListModelButton" highlitImageName:nil withAction:@selector(backToFormer) target:self itemTitle:nil offset:UIControlContentHorizontalAlignmentRight];
    
    self.manager = [FYAFNetworkingManager manager];
    
    [self initMap];
    
    self.chooseDateView = [[FYChooseDateView alloc] initWithFrame:CGRectMake(0, NavH, self.view.width, 55.f)];
    
    __weak typeof(self) mySelf = self;
    
    self.chooseDateView.chooseDateBlock = ^{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            mySelf.chooseDateVC.frame = CGRectMake(0, 0, mySelf.view.width, mySelf.view.height);
        }];
    };
    
    [self.view addSubview:self.chooseDateView];
    
    self.moreChoose = [[FYMoreChoose alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chooseDateView.frame), self.view.width, 40)];
    [self.view addSubview:self.moreChoose];
    
    self.moreChoose.moreChooseBlock = ^(){
        
        FYMoreChooseVC *moreChooseVC = [[FYMoreChooseVC alloc] initWithNibName:@"FYMoreChooseVC" bundle:nil];
        
        moreChooseVC.view.frame = mySelf.view.bounds;
        
        moreChooseVC.returnMoreChooses = ^(NSInteger limitGuestsNum,NSInteger sex,NSMutableArray *spaceTypes,CGFloat startPrice,CGFloat endPrice,NSMutableArray *tempChooseDateArr,NSString *dateIn,NSString *dateOut){
            
            mySelf.chooseDateView.dateIn.text = dateIn;
            mySelf.chooseDateView.dateOut.text = dateOut;
            
            mySelf.sex = sex;
            mySelf.limitGuestsNum = limitGuestsNum;
            mySelf.spaceTypes = spaceTypes;
            mySelf.startPrice = startPrice;
            mySelf.endPrice = endPrice;
            mySelf.chooseType = 2;
            [mySelf getSelectDate:tempChooseDateArr];
            
            [mySelf.mapView removeAnnotations:mySelf.annotationArr];
            [mySelf requestData];
        };

        
        [mySelf.navigationController pushViewController:moreChooseVC animated:YES];
        
    };

    [self initCollectionView];
    
    self.chooseDateVC = [[ZFChooseTimeViewController alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, self.view.height)];
    
    
    self.chooseDateVC.returnDateBlock = ^(NSMutableArray *selectedDateArr)
    {
        mySelf.selectDateArr = selectedDateArr;
        
        NSString *dateInStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[0][0],mySelf.selectDateArr[0][1],mySelf.selectDateArr[0][2]];
        NSDate *dateIn = [mySelf getDateFromString:dateInStr];
        
        NSInteger liveIn = (NSInteger)[dateIn timeIntervalSince1970];
        
        NSString *dateOutStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[1][0],mySelf.selectDateArr[1][1],mySelf.selectDateArr[1][2]];
        NSDate *dateOut = [mySelf getDateFromString:dateOutStr];
        
        NSInteger liveOut = (NSInteger)[dateOut timeIntervalSince1970];
        
        mySelf.chooseDateView.dateIn.text = dateInStr;
        mySelf.chooseDateView.dateOut.text = dateOutStr;
        
        [mySelf.selectDateArr removeAllObjects];
        
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveIn]];
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveOut]];
        [mySelf.mapView removeAnnotations:mySelf.annotationArr];
        
        mySelf.chooseType = 1;
        
        [mySelf getSelectDate:mySelf.selectDateArr];
        
        [mySelf requestData];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseDateVC];
    
    [self requestData];
    
    
}

- (void)getSelectDate:(NSMutableArray *)selectDateArr
{
    self.tempChooseDateArr = [selectDateArr mutableCopy];
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
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.height - 110, self.view.width, 100) collectionViewLayout:flowLayout];
    
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
    
    FYSingleHouseDetailVC *singleHouseDetailVC = [[FYSingleHouseDetailVC alloc] init];
    
    singleHouseDetailVC.spaceId = self.cityHouseArr[indexPath.row].spaceId;
    
    [self.navigationController pushViewController:singleHouseDetailVC animated:YES];
    
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
    
    [self.annotationArr addObject:annotation];
    
    [_mapView addAnnotation:annotation];
}

- (NSString *)getURLStrWithDateIn:(NSNumber *)dateIn DateOut:(NSNumber *)dateOut
{
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%@,\n\"limitGuestsNum\":0,\n\"checkOutDate\":%ld,\n\"districtId\":0,\n\"sex\":0,\n\"checkInDate\":%ld,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\"\n}",self.cityId,dateOut.integerValue,(long)dateIn.integerValue];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSpaceByLatLng.do?";
    
    return [urlStr encodeURLWithParams:params];
}

- (NSString *)getURLWith:(NSInteger)limitNum :(NSNumber *)checkOutDate :(NSArray *)spaceTypes :(NSInteger)sex :(NSNumber *)checkInDate :(CGFloat)startPrice :(CGFloat)endPrice
{
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"cityId\":%ld,\n\"limitGuestsNum\":%ld,\n\"checkOutDate\":%ld,\n\"checkInDate\":%ld,\n\"startPrice\":%f,\n\"spaceTypes\":%@,\n\"userToken\":\"NTE1MmUyODM3N2U5ZDQxYTk0NTQwNDM1OTUxNmI4M2Y2YjJkYzEyOGY1MjM0YTg4\",\n\"sex\":%ld,\n\"districtId\":0,\n\"endPrice\":%f}",self.cityId.integerValue,limitNum,checkOutDate.integerValue,(long)checkInDate.integerValue,startPrice,spaceTypes.mj_JSONString,sex,endPrice];
    
    NSString *urlStr = @"http://www.shafalvxing.com/space/getSharedSpaceByCity.do?";
    
    //    NSLog(@"url : %@",[urlStr encodeURLWithParams:params]);
    
    return [urlStr encodeURLWithParams:params];
}


- (void)requestData
{
    NSString *url = nil;
    
    if (self.chooseType == 1) {
        
        url = [self getURLStrWithDateIn:self.tempChooseDateArr[0] DateOut:self.tempChooseDateArr[1]];
        
    }else if (self.chooseType == 2)
    {
        url = [self getURLWith:self.limitGuestsNum :self.tempChooseDateArr[1] :self.spaceTypes :self.sex :self.tempChooseDateArr[0] :self.startPrice :self.endPrice];

    }

    
    [self.manager GET:url parameters:nil success:^(id responseObject) {
        
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
        
        newAnnotationView.image = [UIImage imageNamed:@"mapHouse_normal"];
        
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-5, 0, 40, 15)];
        label.text = newAnnotationView.annotation.title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9.f];
        
        [newAnnotationView addSubview:label];
        
        return newAnnotationView;
        
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    if (self.lastAnnoView) {
        
        self.lastAnnoView.image = [UIImage imageNamed:@"mapHouse_history"];
        
        UILabel *priceLab = (UILabel *)self.lastAnnoView.subviews[0];
        priceLab.textColor = [UIColor whiteColor];
    }
    
    view.image = [UIImage imageNamed:@"mapHouse_select"];
    
     UILabel *priceLab = (UILabel *)view.subviews[0];
    priceLab.textColor = [UIColor colorWithHexString:@"#58BDC0"];
    
    self.lastAnnoView = view;
    
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

- (void)setTempChooseDateArr:(NSMutableArray *)tempChooseDateArr
{
    _tempChooseDateArr = tempChooseDateArr;
}

- (void)backToFormer
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
