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


@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)FYHomeViewData *homeViewData;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomeViewController

//重写状态栏方法
- (UIStatusBarStyle)preferredStatusBarStyle
{
    [super preferredStatusBarStyle];
    
    return UIStatusBarStyleLightContent;
}

//view即将出现时隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //强制调用状态栏方法
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏设置为黑色
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initCollectionView];
    
    [self requestData];
    
    
}

//初始化collectionView
- (void)initCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, kScreenFrameH - TabBarH) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册cell的方法（注意加载Nib的方法）
    [self.collectionView registerNib:[UINib nibWithNibName:@"FYHomeViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
    //注册Header
    [self.collectionView registerClass:[FYCollectionHeader class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"header"];
    
    //注册Footer
    [self.collectionView registerClass:[FYCollectionFooter class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:@"footer"];
    
    self.flowLayout.headerReferenceSize = CGSizeMake(kScreenFrameW, 0.55f * kScreenFrameW);
    
    self.flowLayout.footerReferenceSize = CGSizeMake(kScreenFrameW, 0.4526f * kScreenFrameW);
    
    [self.view addSubview:self.collectionView];
    
}

//请求数据
- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://www.shafalvxing.com/index/indexLoadInfo.do" parameters:@{@"deviceToken":@"b66411928c928500742567ffd43b991a8eb21b9d683180e346d7ebcceed1e94d" ,@"userToken":@"NDRjYmJiZWJlZWJjMmE1NjQ2NmVhNzUxMjY2YzRhMWQ4NDE0MjBhMjMyNjEyZTQ3"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [[responseObject objectForKey:@"data"] objectForKey:@"homePageInfo"];
        
        //模型嵌套模型
        [FYHomeViewData mj_setupObjectClassInArray:^NSDictionary *{
            
            return @{
                     @"topBanner" : @"FYHomeViewBannerData",
                     
                     @"recommendCity" : @"FYHomeViewCityData"
                     
                     };
        }];
        
        self.homeViewData = [FYHomeViewData mj_objectWithKeyValues:dict];
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error : %@",error);
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
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        FYCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        //把控制器传到header里
        header.myHostVC = self;
        
        header.bannerArr = self.homeViewData.topBanner;
        
        reusableView = header;
    }
    
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
    NSLog(@"点击的城市编号%@",self.homeViewData.recommendCity[indexPath.row].ID);
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
    
//    self.flowLayout.headerReferenceSize = CGSizeMake(500, 400);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
