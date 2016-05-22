//
//  CYThirdView.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYThirdView.h"

@implementation CYThirdView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYThirdView");
        self.icon.layer.cornerRadius = 35;
    }
    return self;
}

@end
