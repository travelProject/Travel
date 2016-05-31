//
//  FYCityHouseListData.m
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseListData.h"

@implementation FYCityHouseListData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [FYCityHouseListData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            
            return @{
                     @"userIdenStatus" : @"userIdentificationStatus",
                     @"collStatus" : @"collectionStatus"
                     };
        }];
        
    }
    return self;
}

@end
