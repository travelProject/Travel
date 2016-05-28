//
//  CYFourthView.m
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYFourthView.h"

@interface CYFourthView () <BMKMapViewDelegate>

@end

@implementation CYFourthView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = kLoadViewWithNIB(@"CYFourthView");
        self.map.delegate = self;
    }
    return self;
}



@end
