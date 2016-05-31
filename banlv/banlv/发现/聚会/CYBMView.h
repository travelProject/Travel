//
//  CYBMView.h
//  banlv
//
//  Created by lcy on 16/5/30.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBMView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
//图片处理：拉伸，压缩
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *space;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *toprice;
@property (weak, nonatomic) IBOutlet UISwitch *weixin;
@property (weak, nonatomic) IBOutlet UISwitch *zhifubao;

@end
