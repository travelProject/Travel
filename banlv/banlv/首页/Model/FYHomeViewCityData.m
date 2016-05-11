//
//  FYHomeViewCityData.m
//  banlv
//
//  Created by lfy on 16/5/11.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYHomeViewCityData.h"

@implementation FYHomeViewCityData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [FYHomeViewCityData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            
            return @{
                     @"ID" : @"id",
                     };
        }];
        
    }
    return self;
}

@end
