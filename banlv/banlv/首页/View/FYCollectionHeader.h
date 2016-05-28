//
//  FYCollectionHeader.h
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYHomeViewBannerData.h"

typedef void(^ReturnCurrentPageAndTotal)(NSString *page);

@interface FYCollectionHeader : UIView

@property(nonatomic,strong) UICollectionView *bannerCollecView;

@property(nonatomic,strong) UIPageControl *bannerPage;

@property(nonatomic,strong) NSArray<FYHomeViewBannerData *> *bannerArr;

@property(nonatomic,strong) UIViewController *myHostVC;

@property(nonatomic,copy) ReturnCurrentPageAndTotal returnCurrentPageAndTotal;

//单个房间顶部轮播图
@property(nonatomic,strong) NSArray *topPicArr;

@property(nonatomic,assign) NSInteger bannerType;

@end
