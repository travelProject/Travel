//
//  FYLookMoreCityData.h
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FYSingleCityData.h"

@interface FYLookMoreCityData : NSObject

@property (nonatomic,copy)NSString *word;

@property (nonatomic,strong)NSArray<FYSingleCityData *> *city;

@end
