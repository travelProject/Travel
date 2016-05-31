
//
//  BLCashAccountView.m
//  banlv
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLCashAccountView.h"
#import "BLPaymentMethodsController.h"
@implementation BLCashAccountView
+ (id)loadNib{
    return kLoadViewWithNIB(NSStringFromClass([self class]));
}

- (IBAction)addPaymentMethods:(id)sender {
//    BLPaymentMethodsController *payment = [[BLPaymentMethodsController alloc] init];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
