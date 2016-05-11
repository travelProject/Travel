//
//  FYHomeViewData.h
//  banlv
//
//  Created by lfy on 16/5/11.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYHomeViewBannerData.h"
#import "FYHomeViewCityData.h"

@interface FYHomeViewData : NSObject

//banner顶部图片
@property(nonatomic,strong)NSArray<FYHomeViewBannerData *> *topBanner;

//中部热门城市
@property(nonatomic,strong)NSArray<FYHomeViewCityData *> *recommendCity;

//底部查看更多城市图片
@property(nonatomic,copy)NSString *bottomPic;

@end
