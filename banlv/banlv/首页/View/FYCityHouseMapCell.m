//
//  FYCityHouseMapCell.m
//  banlv
//
//  Created by lfy on 16/5/17.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseMapCell.h"

@implementation FYCityHouseMapCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((self.width - 100) / 2, (self.height - 15) / 2, 100, 15)];
        
        self.label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.label];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
