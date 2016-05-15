//
//  FYCarouselCell.m
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCarouselCell.h"

@implementation FYCarouselCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:self.picImageView];
        
    }
    return self;
}

@end
