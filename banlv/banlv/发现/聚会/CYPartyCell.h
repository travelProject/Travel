//
//  CYPartyCell.h
//  banlv
//
//  Created by lcy on 16/5/15.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CYPartyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *joinCount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *time;
@end
