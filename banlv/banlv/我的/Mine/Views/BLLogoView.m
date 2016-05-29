//
//  BLLogoView.m
//  伴旅
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLLogoView.h"

@implementation BLLogoView


+(id)loadView{
    
    return kLoadViewWithNIB(NSStringFromClass([self class]));
}

@end
