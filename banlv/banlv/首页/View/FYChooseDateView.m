//
//  FYChooseDateView.m
//  banlv
//
//  Created by lfy on 16/5/21.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYChooseDateView.h"

@implementation FYChooseDateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.liveIn = [[UILabel alloc] init];
    [self setAttributeWithLabel:self.liveIn Title:@"入住" TextColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1.0]];
    
    self.dateIn = [[UILabel alloc] init];
    [self setAttributeWithLabel:self.dateIn Title:@"选择入住时间" TextColor:[UIColor colorWithRed:0.37 green:0.74 blue:0.75 alpha:1.0]];
    
    self.seperateLine = [[UILabel alloc] init];
    self.seperateLine.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    
    self.liveOut = [[UILabel alloc] init];
    [self setAttributeWithLabel:self.liveOut Title:@"离开" TextColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1.0]];
    
    self.dateOut = [[UILabel alloc] init];
    [self setAttributeWithLabel:self.dateOut Title:@"选择离开时间" TextColor:[UIColor colorWithRed:0.37 green:0.74 blue:0.75 alpha:1.0]];
    

    [self addSubview:self.liveIn];
    [self addSubview:self.dateIn];
    [self addSubview:self.seperateLine];
    [self addSubview:self.liveOut];
    [self addSubview:self.dateOut];
    
    UITapGestureRecognizer *chooseDateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDateAct)];
    
    [self addGestureRecognizer:chooseDateTap];
    
}

- (void)chooseDateAct
{
    NSLog(@"开始选择日期");
}



- (void)setAttributeWithLabel:(UILabel *)label Title:(NSString *)title TextColor:(UIColor *)color
{
    label.text = title;
    
    label.textColor = color;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:16.f];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.liveIn.frame = CGRectMake((self.width / 2 - 100) / 2, 10, 100, 20);
    
    self.dateIn.frame = CGRectMake((self.width / 2 - 200) / 2, CGRectGetMaxY(self.liveIn.frame) + 5, 200, 20);
    
    self.seperateLine.frame = CGRectMake((self.width - 2) / 2, 5, 2, self.height - 10);
    
    self.liveOut.frame = CGRectMake(self.width / 2 + (self.width / 2 - 100) / 2, 10, 100, 20);
    self.dateOut.frame = CGRectMake(self.width / 2 + (self.width / 2 - 200) / 2, CGRectGetMaxY(self.liveOut.frame) + 5, 200, 20);
    
}

@end
