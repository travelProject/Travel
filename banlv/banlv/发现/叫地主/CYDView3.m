//
//  CYDView3.m
//  banlv
//
//  Created by lcy on 16/5/23.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDView3.h"

@implementation CYDView3

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYDView3");
    }
    return self;
}
@end
