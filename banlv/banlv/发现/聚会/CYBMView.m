//
//  CYBMView.m
//  banlv
//
//  Created by lcy on 16/5/30.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYBMView.h"

@implementation CYBMView


- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYBMView");
//        self.toprice.text = self.price.text;
        self.weixin.on =YES;
            self.zhifubao.on = NO;
        
        
        
    }
    return self;
}

@end
