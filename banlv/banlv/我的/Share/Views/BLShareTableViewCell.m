//
//  BLShareTableViewCell.m
//  banlv
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLShareTableViewCell.h"

@implementation BLShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.clickableView.backgroundColor = [UIColor whiteColor];
    self.clickableView.layer.cornerRadius = 5.f;
    self.clickableView.layer.masksToBounds = YES;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
