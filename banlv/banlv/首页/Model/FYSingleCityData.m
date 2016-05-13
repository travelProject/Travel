//
//  FYSingleCityData.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSingleCityData.h"

@implementation FYSingleCityData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [FYSingleCityData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            
            return @{
                     @"ID" : @"id",
                     };
        }];
        
    }
    return self;
}

@end
