//
//  JXHomeHeaderView.m
//  uicollectionView轮播
//
//  Created by lixiujuan on 16/5/6.
//  Copyright © 2016年 lxj. All rights reserved.
//

#import "BLBannerView.h"
#import "BLBannerCell.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define CellHeight 200
@implementation BLBannerView

- (void)awakeFromNib{
    [self.collectionView registerNib:[UINib nibWithNibName:@"BLBannerCell" bundle:nil] forCellWithReuseIdentifier:@"banner"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    _count = 0;
    
    _imageArr = [@[@"Z", @"Z", @"Z"] mutableCopy];
    _pageControl.numberOfPages = [_imageArr count];
    _pageControl.currentPage = _count;
    
    [self createTimer];
 
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView setContentOffset:CGPointMake(Width, 0)];
    
    self.pageControl.currentPage = _count;
    
    return (CGSize){Width,CellHeight};
}

#pragma mark- UICollectionViewDataSource
//一共多少组，默认为1组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BLBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"banner" forIndexPath:indexPath];
    cell.bannerImage.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    return cell;
}

#pragma mark-UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%@",indexPath);
    NSLog(@"%@",_imageArr[indexPath.row]);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}


#pragma maek - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_collectionView.contentOffset.x >= 2*Width)
    {
        _count == [_imageArr count] -1 ? _count = 0 : _count++;
        NSString *tempFirst =  _imageArr[0];
        [_imageArr removeObjectAtIndex:0];
        [_imageArr addObject:tempFirst];
        [_collectionView reloadData];
    }
    if (_collectionView.contentOffset.x <= 0)
    {
        _count == 0 ? _count = (int)[_imageArr count] - 1:self.count --;
        NSString *tempLase = [_imageArr lastObject];
        [_imageArr removeLastObject];
        [_imageArr insertObject:tempLase atIndex:0];
        [_collectionView reloadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    //拖拽轮播图的时候让定时器暂停
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}

- (void)changePic
{
    [self.collectionView setContentOffset:CGPointMake(2*Width, 0.f) animated:YES];
}

- (void)createTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(changePic) userInfo:nil repeats:YES];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:_timer forMode:NSRunLoopCommonModes];
}

@end
