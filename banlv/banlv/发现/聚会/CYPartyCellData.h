//
//  CYPartyCellData.h
//  banlv
//
//  Created by lcy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPartyCellData : NSObject
@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,strong)NSArray *pics;

@property(nonatomic,copy)NSString *joinCount;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *cityName;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *avatar;

@end
