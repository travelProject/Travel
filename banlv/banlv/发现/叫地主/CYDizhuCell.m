//
//  CYDizhuCell.m
//  banlv
//
//  Created by lcy on 16/5/11.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDizhuCell.h"

@interface CYDizhuCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;


@end

@implementation CYDizhuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.userName setFont:[UIFont fontWithName:@"STHeitiK-Medium" size:17 ]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgImg.layer.cornerRadius = 5.f;
    self.bgImg.layer.masksToBounds = YES;
    
}

- (instancetype)init{
    
    
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    self.imageH.constant = ((float)840 / 1015) * kScreenFrameW;

};

- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(15, frame.origin.y + 15, kScreenFrameW - 15 * 2, frame.size.height - 15);
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
