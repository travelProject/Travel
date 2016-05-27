//
//  FYSingleHouseDetailData.m
//  banlv
//
//  Created by lfy on 16/5/26.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYSingleHouseDetailData.h"

@implementation FYSingleHouseDetailData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [FYSingleHouseDetailData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            
            return @{
                     @"descrip" : @"description",
                     };
        }];
        
    }
    return self;
}

@end
