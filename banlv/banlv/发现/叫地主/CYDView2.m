//
//  CYDView2.m
//  banlv
//
//  Created by lcy on 16/5/23.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDView2.h"

@implementation CYDView2
- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYDView2");
    }
    return self;
}
@end
