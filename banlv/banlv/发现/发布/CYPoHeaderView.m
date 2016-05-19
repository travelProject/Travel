//
//  CYPoHeaderView.m
//  banlv
//
//  Created by lcy on 16/5/18.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYPoHeaderView.h"

@interface CYPoHeaderView  ()<UITextFieldDelegate>

@end

@implementation CYPoHeaderView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self = kLoadViewWithNIB(@"CYPoHeaderView");
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
