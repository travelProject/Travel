//
//  FYCityHouseMapVC.h
//  banlv
//
//  Created by lfy on 16/5/17.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCityHouseMapVC : BLBackViewController

@property (nonatomic,copy)NSString *cityId;

@property (nonatomic,copy)NSString *cityName;

@property(nonatomic,strong)NSMutableArray *selectDateArr;

@property(nonatomic,strong) NSMutableArray<BMKPointAnnotation *> *annotationArr;

@property(nonatomic,assign) NSInteger limitGuestsNum;

@property(nonatomic,strong) NSMutableArray *spaceTypes;

@property(nonatomic,assign) NSInteger sex;

@property(nonatomic,assign) CGFloat startPrice;

@property(nonatomic,assign) CGFloat endPrice;

@property(nonatomic,strong) NSMutableArray *tempChooseDateArr;

//判断选择条件类型
@property(nonatomic,assign) NSInteger chooseType;

@end
