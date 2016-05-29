//
//  BLCouponView.m
//  banlv
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLCouponView.h"

@implementation BLCouponView
+ (id)loadNib{
    return kLoadViewWithNIB(NSStringFromClass([self class]));
}
- (IBAction)exchange:(id)sender {
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.exchangeView.layer.borderWidth = 2;
    self.exchangeView.layer.cornerRadius = 5.f;
    self.exchangeView.layer.masksToBounds = YES;
    self.exchangeView.layer.borderColor = [UIColor colorWithHexString:@"#58bdc0"].CGColor;
    self.exchangeBtn.backgroundColor = [UIColor colorWithHexString:@"#58bdc0"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
