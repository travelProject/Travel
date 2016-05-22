//
//  CYFristView.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYFristView.h"

@implementation CYFristView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYFristView");
        
    }
    return self;
}

@end
