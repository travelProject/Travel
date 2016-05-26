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

@end
