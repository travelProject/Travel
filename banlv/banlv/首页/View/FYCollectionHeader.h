//
//  FYCollectionHeader.h
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYHomeViewBannerData.h"

@interface FYCollectionHeader : UICollectionReusableView

@property(nonatomic,strong) UICollectionView *bannerCollecView;

@property(nonatomic,strong) UIPageControl *bannerPage;

@property(nonatomic,strong) NSArray<FYHomeViewBannerData *> *bannerArr;

@end
