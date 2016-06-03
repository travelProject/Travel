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

//顶部haeder
#import "FYCollectionHeader.h"

//底部footer
#import "FYCollectionFooter.h"

//点击城市跳转的城市民宿列表
#import "FYCityHouseListVC.h"


@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)FYHomeViewData *homeViewData;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,strong)FYCollectionHeader *header;

@end

@implementation HomeViewController

//view即将出现时隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏设置为黑色
}

//view即将消失显示导航栏
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initCollectionView];
    
    [self requestData];
    
}

//初始化collectionView
- (void)initCollectionView
{
    self.header = [[FYCollectionHeader alloc] initWithFrame:CGRectMake(0, -0.55f * kScreenFrameW, kScreenFrameW, 0.55f * kScreenFrameW)];
    
    //设置轮播图片的数据源类型
    self.header.bannerType = 1;
    
    self.header.backgroundColor = [UIColor grayColor];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - TabBarH) collectionViewLayout:self.flowLayout];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0.55f * kScreenFrameW, 0, 0, 0);
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    
    //注册cell的方法（注意加载Nib的方法）
    [self.collectionView registerNib:[UINib nibWithNibName:@"FYHomeViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];

    
    //注册Footer
    [self.collectionView registerClass:[FYCollectionFooter class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:@"footer"];

    
    self.flowLayout.footerReferenceSize = CGSizeMake(kScreenFrameW, 0.4526f * kScreenFrameW);
    
    [self.collectionView addSubview:self.header];
    
    [self.view addSubview:self.collectionView];
    
}

//请求数据
- (void)requestData
{
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    [manager GET:@"http://www.shafalvxing.com/index/indexLoadInfo.do" parameters:@{@"deviceToken":@"b66411928c928500742567ffd43b991a8eb21b9d683180e346d7ebcceed1e94d" ,@"userToken":@"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3"} success:^(id responseObject) {
        
        NSDictionary *dict = [[responseObject objectForKey:@"data"] objectForKey:@"homePageInfo"];
        
        
        
        //模型嵌套模型
        [FYHomeViewData mj_setupObjectClassInArray:^NSDictionary *{
            
            return @{
                     @"topBanner" : @"FYHomeViewBannerData",
                     
                     @"recommendCity" : @"FYHomeViewCityData"
                     
                     };
        }];
        
        self.homeViewData = [FYHomeViewData mj_objectWithKeyValues:dict];
        
//        把控制器传到header里
        self.header.myHostVC = self;
        
        self.header.bannerArr = self.homeViewData.topBanner;
        
        [self.collectionView reloadData];
        
    } failur:^(NSError *error) {
        
        CYLog(@"error : %@",error);
        
    }];
    
}



#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeViewData.recommendCity.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYHomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cityData = self.homeViewData.recommendCity[indexPath.row];
    
    return cell;
}

//header/footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        FYCollectionFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        //把控制器传到header里
        footer.myHostVC = self;
        
        footer.footerPic = self.homeViewData.bottomPic;
        
        reusableView = footer;
    }
    
    return reusableView;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYCityHouseListVC *cityHouseListVC = [[FYCityHouseListVC alloc] init];
    
    cityHouseListVC.cityId = self.homeViewData.recommendCity[indexPath.row].ID;
    
    cityHouseListVC.cityName = self.homeViewData.recommendCity[indexPath.row].cityNameCh;
    
    [self.navigationController pushViewController:cityHouseListVC animated:YES];
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenFrameW - 3) / 2, (kScreenFrameW - 3) / (0.748f * 2));
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

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    if (self.collectionView.contentOffset.y > -280.f) {
//        
//        return;
//    }
//    
//    [UIView animateWithDuration:0.00001f animations:^{
//        
//        self.header.frame = CGRectMake(0, self.collectionView.contentOffset.y, self.view.width, -self.collectionView.contentOffset.y);
//        self.header.bannerCollecView.frame = CGRectMake(0, 0, -(self.header.width - self.view.width) / 2, self.header.height);
//        
//        [self.header.bannerCollecView reloadData];
//        
//        
//    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
