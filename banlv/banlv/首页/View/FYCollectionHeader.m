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

@interface FYCollectionHeader () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
        
        [self addSubview:self.bannerCollecView];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"banner的数量:%ld",self.bannerArr.count);
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

//bannerArr属性的setter方法
- (void)setBannerArr:(NSArray<FYHomeViewBannerData *> *)bannerArr
{
    
    _bannerArr = bannerArr;
    
    //一定要reloadData一下（不然代理方法只会执行一次）
    [self.bannerCollecView reloadData];
    
}


@end
