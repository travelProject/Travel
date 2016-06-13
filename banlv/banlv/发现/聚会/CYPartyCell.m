//
//  CYPartyCell.m
//  banlv
//
//  Created by lcy on 16/5/15.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYPartyCell.h"

@interface CYPartyCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;


@end

@implementation CYPartyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgImgView.layer.cornerRadius = 5.f;
    self.bgImgView.layer.masksToBounds = YES;
}


- (void)updateConstraints
{
    [super updateConstraints];
    
    self.imageH.constant = kScreenFrameW * ((float)420 / 510 );
}

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
