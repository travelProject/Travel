//
//  FYMoreChoose.m
//  banlv
//
//  Created by lfy on 16/5/19.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYMoreChoose.h"

@implementation FYMoreChoose

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.text = @"更多筛选条件";
        self.font = [UIFont systemFontOfSize:15.f];
        self.textColor = ThemeColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreChooseAction)];
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)moreChooseAction
{
    self.moreChooseBlock();
}


@end
