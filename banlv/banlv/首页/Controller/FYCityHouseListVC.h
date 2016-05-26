//
//  FYCityHouseList.h
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

//城市房间数据模型
#import "FYCityHouseListData.h"

@interface FYCityHouseListVC : BLBackViewController

//存放城市房间的数组
@property(nonatomic,strong) NSMutableArray<FYCityHouseListData *> *cityHouseArr;

@property(nonatomic,copy) NSString *cityId;

@property(nonatomic,copy) NSString *cityName;

@property(nonatomic,strong)NSMutableArray *selectDateArr;

@property(nonatomic,assign) NSInteger limitGuestsNum;

@property(nonatomic,strong) NSMutableArray *spaceTypes;

@property(nonatomic,assign) NSInteger sex;

@property(nonatomic,assign) CGFloat startPrice;

@property(nonatomic,assign) CGFloat endPrice;

@property(nonatomic,strong) NSMutableArray *tempChooseDateArr;

//判断选择条件类型
@property(nonatomic,assign) NSInteger chooseType;

@end
