//
//  FYCityHouseList.h
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCityHouseListVC : BLBackViewController

@property(nonatomic,copy) NSString *cityId;

@property(nonatomic,copy) NSString *cityName;

@property(nonatomic,strong)NSMutableArray *selectDateArr;

@property(nonatomic,assign) NSInteger limitGuestsNum;

@property(nonatomic,strong) NSMutableArray *spaceTypes;

@property(nonatomic,assign) NSInteger sex;

@property(nonatomic,assign) CGFloat startPrice;

@property(nonatomic,assign) CGFloat endPrice;

//判断选择条件类型
@property(nonatomic,assign) NSInteger chooseType;

@end
