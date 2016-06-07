//
//  FYCollectionHeader.m
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCollectionHeader.h"

//bannerCell
#import "FYHeaderViewCell.h"

//webviewVC
#import "FYHomeWebViewVC.h"

#define MaxSection 100

@interface FYCollectionHeader () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation FYCollectionHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.bannerCollecView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:self.flowLayout];
        
        self.bannerCollecView.showsHorizontalScrollIndicator = NO;
        self.bannerCollecView.pagingEnabled = YES;
        self.bannerCollecView.delegate = self;
        self.bannerCollecView.dataSource = self;
        self.bannerCollecView.backgroundColor = [UIColor redColor];
        
        //注册cell的方法（注意加载Nib的方法）
        [self.bannerCollecView registerNib:[UINib nibWithNibName:@"FYHeaderViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"headerCell"];
        
        [self addSubview:self.bannerCollecView];
        
        self.bannerPage = [[UIPageControl alloc] initWithFrame:CGRectMake((self.width - 150) / 2, self.height - 20, 150, 10)];
        self.bannerPage.currentPage = 0;
        self.bannerPage.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.bannerPage.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self addSubview:self.bannerPage];
        
        [self addTimer];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    [UIView animateWithDuration:0.00001f animations:^{
        
        self.bannerCollecView.frame = CGRectMake((kScreenFrameW - self.width) / 2, 0, self.width, self.height);
        self.flowLayout.itemSize = self.bannerCollecView.size;
        
        self.bannerPage.frame = CGRectMake((self.width - 150) / 2, self.height - 20, 150, 10);
        
        FYHeaderViewCell *cell = (FYHeaderViewCell *)[self.bannerCollecView cellForItemAtIndexPath:[[self.bannerCollecView indexPathsForVisibleItems] lastObject]];
        
        cell.frame = CGRectMake(cell.frame.origin.x, 0, self.bannerCollecView.size.width, self.bannerCollecView.size.height);
        
//        NSLog(@"cell`s size is : %@",[NSValue valueWithCGSize:cell.size]);
        
    }];
    
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (NSIndexPath *)resetIndexPath
{
    //当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.bannerCollecView indexPathsForVisibleItems] lastObject];
    
    //马上显示回最中间那组对应的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSection / 2];
    
    
    if (self.topPicArr.count != 0) {
        
        [self.bannerCollecView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
    }else if (self.bannerArr.count != 0)
    {
        [self.bannerCollecView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //返回重新设置后的索引
    return currentIndexPathReset;
    
}

//下一页
- (void)nextPage
{
    //获取当前正在展示的位置
    NSIndexPath *currentIndexPath = [self resetIndexPath];
    
    //计算下一个显示的位置
    NSInteger item = currentIndexPath.item + 1;
    NSInteger section = currentIndexPath.section;
    
    if (self.bannerType == 1) {
       
        if (item == self.bannerArr.count) {
            
            item = 0;
            section += 1;
        }
        
    }else if (self.bannerType == 2)
    {
        if (item == self.topPicArr.count) {
            
            item = 0;
            section += 1;
        }
        
    }
    
    //生成下一个位置
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    [self.bannerCollecView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
}

- (void)removeTimer
{
    //停止定时器
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return MaxSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.bannerType == 1) {
        
        return self.bannerArr.count;
        
    }else if (self.bannerType ==2)
    {
        return self.topPicArr.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    if (self.bannerType == 1) {
       
        cell.picUrl = self.bannerArr[indexPath.row].advPic;
        
        cell.backgroundColor = [UIColor yellowColor];
        
    }else if (self.bannerType == 2)
    {
        cell.picUrl = self.topPicArr[indexPath.row];
    }
    
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bannerType == 1) {
        
        FYHomeWebViewVC *webViewVC = [[FYHomeWebViewVC alloc] init];
        
        webViewVC.urlString = self.bannerArr[indexPath.row].advUrl;
        
        [self.myHostVC.navigationController pushViewController:webViewVC animated:YES];
    }
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bannerCollecView.width, self.bannerCollecView.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.bannerType == 1) {
        
        NSInteger index = (int)(self.bannerCollecView.contentOffset.x / self.width + 0.5) % self.bannerArr.count;
        
        self.bannerPage.currentPage = index;
        
    }else if (self.bannerType == 2)
    {
        NSInteger index = (int)(self.bannerCollecView.contentOffset.x / self.width + 0.5) % self.topPicArr.count;
        
        self.bannerPage.currentPage = index;
        
        NSString *page = [NSString stringWithFormat:@"%ld/%ld",self.bannerPage.currentPage + 1,self.bannerPage.numberOfPages];
        
        self.returnCurrentPageAndTotal(page);
    }
    
}

//bannerArr属性的setter方法
- (void)setBannerArr:(NSArray<FYHomeViewBannerData *> *)bannerArr
{
    
    _bannerArr = bannerArr;
    
    if (_bannerArr.count > 0) {
        
        
        //设置pageControl页数
        self.bannerPage.numberOfPages = _bannerArr.count;
        
        //一定要reloadData一下（不然代理方法只会执行一次）
        [self.bannerCollecView reloadData];
    }
    
    
}

- (void)setMyHostVC:(UIViewController *)myHostVC
{
    _myHostVC = myHostVC;
}

- (void)setTopPicArr:(NSArray *)topPicArr
{
    _topPicArr = topPicArr;
    
    if (_topPicArr.count > 0) {
        
        
        //设置pageControl页数
        self.bannerPage.numberOfPages = _topPicArr.count;
        
        //一定要reloadData一下（不然代理方法只会执行一次）
        [self.bannerCollecView reloadData];
    }
}

- (void)setBannerType:(NSInteger)bannerType
{
    _bannerType = bannerType;

}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
