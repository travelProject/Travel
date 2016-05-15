//
//  JXHomeHeaderView.h
//  uicollectionView轮播
//
//  Created by lixiujuan on 16/5/6.
//  Copyright © 2016年 lxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLBannerView : UIView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,assign) int count;
@property (nonatomic,strong) NSTimer *timer;
@end
