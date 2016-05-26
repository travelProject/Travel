//
//  CYDView1.m
//  banlv
//
//  Created by lcy on 16/5/23.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDView1.h"

@implementation CYDView1

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYDView1");
    }
    return self;
}

@end
