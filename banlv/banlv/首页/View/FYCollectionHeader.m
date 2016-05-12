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

#define MaxSection 100

@interface FYCollectionHeader () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation FYCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.bannerCollecView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, 0.55f * kScreenFrameW) collectionViewLayout:flowLayout];
        self.bannerCollecView.backgroundColor = [UIColor clearColor];
        self.bannerCollecView.showsHorizontalScrollIndicator = NO;
        self.bannerCollecView.pagingEnabled = YES;
        self.bannerCollecView.delegate = self;
        self.bannerCollecView.dataSource = self;
        
        //注册cell的方法（注意加载Nib的方法）
        [self.bannerCollecView registerNib:[UINib nibWithNibName:@"FYHeaderViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"headerCell"];
        
        /*------NSTimer完美的解决了一开始self.bannerArr.count为0（为0会crash）的头疼问题----*/
        //默认显示滚到最中间的那组
//        [self.bannerCollecView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSection / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
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
    [self.bannerCollecView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
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
    
    if (item == self.bannerArr.count) {
        
        item = 0;
        section += 1;
    }
    
    //生成下一个位置
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    //通过动画滚动到下一个位置
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

    return self.bannerArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FYHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    cell.picUrl = self.bannerArr[indexPath.row].advPic;
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的banner标题：%@",self.bannerArr[indexPath.row].advTitle);
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenFrameW, 0.55f * kScreenFrameW);
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
    NSInteger index = (int)(self.bannerCollecView.contentOffset.x / self.width + 0.5) % self.bannerArr.count;
    
    self.bannerPage.currentPage = index;
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


@end
