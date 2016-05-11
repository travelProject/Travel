//
//  HomeViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "HomeViewController.h"

//数据模型
#import "FYHomeViewData.h"

//cell
#import "FYHomeViewCell.h"

@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)FYHomeViewData *homeViewData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initCollectionView];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://www.shafalvxing.com/index/indexLoadInfo.do" parameters:@{@"deviceToken":@"b66411928c928500742567ffd43b991a8eb21b9d683180e346d7ebcceed1e94d" ,@"userToken":@"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [[responseObject objectForKey:@"data"] objectForKey:@"homePageInfo"];
        
        [FYHomeViewData mj_setupObjectClassInArray:^NSDictionary *{
            
            return @{
                     @"topBanner" : @"FYHomeViewBannerData",
                     
                     @"recommendCity" : @"FYHomeViewCityData"
                     
                     };
        }];
        
        self.homeViewData = [FYHomeViewData mj_objectWithKeyValues:dict];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
//    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
//    
//    [manager GET:@"http://www.shafalvxing.com/index/indexLoadInfo.do" parameters:@{@"deviceToken":@"b66411928c928500742567ffd43b991a8eb21b9d683180e346d7ebcceed1e94d" ,@"userToken":@"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3"} success:^(id responseObject) {
//        
//        NSDictionary *dict = [[responseObject objectForKey:@"data"] objectForKey:@"homePageInfo"];
//        
//        [FYHomeViewData mj_setupObjectClassInArray:^NSDictionary *{
//            
//            return @{
//                     @"topBanner" : @"FYHomeViewBannerData",
//                     
//                     @"recommendCity" : @"FYHomeViewCityData"
//                     
//                     };
//        }];
//        
//        FYHomeViewData *homeViewData = [FYHomeViewData mj_objectWithKeyValues:dict];
//
//        NSLog(@"首页数据:%@",homeViewData.recommendCity);
//        
//    } failur:^(NSError *error) {
//        
//        
//    }];
    
    
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - TabBarH) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[[[NSBundle mainBundle] loadNibNamed:@"FYHomeViewCell" owner:nil options:nil] firstObject] forCellWithReuseIdentifier:@"cell"];
    
//    [self.view addSubview:self.collectionView];
    
}




#pragma mark -- UICollectionViewDataSource

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.homeViewData.recommendCity.count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeViewData.recommendCity.count;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYHomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cityData = self.homeViewData.recommendCity[indexPath.row];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的城市编号%@",self.homeViewData.recommendCity[indexPath.row].ID);
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3.f, 0.f, 3.f, 0.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.f;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    
//}




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
