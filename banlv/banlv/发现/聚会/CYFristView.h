//
//  CYFristView.h
//  banlv
//
//  Created by lcy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//
#import "FYCarouselPic.h"
#import <UIKit/UIKit.h>

@interface CYFristView : UIView
@property (weak, nonatomic) IBOutlet FYCarouselPic *lunbo;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *dizhi;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
