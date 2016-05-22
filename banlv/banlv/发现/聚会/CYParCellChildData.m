//
//  CYParCellChildData.m
//  banlv
//
//  Created by lcy on 16/5/22.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYParCellChildData.h"

@implementation CYParCellChildData


- (instancetype)init{
    self = [super init];
    if (self) {
        [CYParCellChildData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"description1" : @"description" ,
                     };
        }];
    }
    return self;
}
@end
