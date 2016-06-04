//
//  FYHeaderViewCell.m
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYHeaderViewCell.h"

@interface FYHeaderViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerPic;

@end
@implementation FYHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPicUrl:(NSString *)picUrl
{
    _picUrl = picUrl;
    
    [self.bannerPic sd_setImageWithURL:[NSURL URLWithString:_picUrl] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
}

@end
