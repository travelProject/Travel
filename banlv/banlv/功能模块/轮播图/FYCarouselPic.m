//
//  FYCarouselPic.m
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCarouselPic.h"

//图片cell
#import "FYCarouselCell.h"

#define MaxSection 30

@interface FYCarouselPic () <UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation FYCarouselPic

//从xib加载时调用
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initCollectionView];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //分页错位的原因（frame不要用self.bounds）
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrameW, 280.f) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[FYCarouselCell class] forCellWithReuseIdentifier:@"picCell"];
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.collectionView];
    
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenFrameW, 280.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MaxSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FYCarouselCell *picCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picCell" forIndexPath:indexPath];
    
    [picCell.picImageView sd_setImageWithURL:[NSURL URLWithString:self.picArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
    
    return picCell;
}

//setter方法
- (void)setPicArr:(NSArray *)picArr
{
    
    _picArr = picArr;
    
    if (_picArr.count > 0) {
        
        [self.collectionView reloadData];
        
        //BUG（初始创建的cell轮播错位）
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSection / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
    }
    
}

@end
