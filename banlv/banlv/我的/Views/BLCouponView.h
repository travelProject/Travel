//
//  BLCouponView.h
//  banlv
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCouponView : UIView
@property (weak, nonatomic) IBOutlet UIView *exchangeView;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
+ (id)loadNib;
@end
