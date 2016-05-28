//
//  CYSecondView.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYSecondView.h"

@implementation CYSecondView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYSecondView");
        
        
//        [self.deciption1 setFont:[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:17 ]];
//        self.size.width = kScreenFrameW;
    }
    return self;
}

@end
