//
//  BLUserInfoView.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLIconView.h"


@implementation BLIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0, 0, kScreenFrameW, 500);

    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.midView.backgroundColor = [UIColor clearColor];
    //设置成圆形，用到layer属性
//    self.layer.cornerRadius = 40.f;
//    self.iconBtn.layer.masksToBounds = YES;
    self.iconImg.layer.cornerRadius = 45.f;
    self.iconImg.layer.masksToBounds = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToUserInfo:)];
//    [self.midView addGestureRecognizer:tap];

}

+(id)loadView{
    
    return kLoadViewWithNIB(NSStringFromClass([self class]));
}
//- (void)jumpToUserInfo:(id)sender{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    BLUserInfoView *userInfo = [BLUserInfoView loadView];
//    userInfo.frame = kScreenFrame;
//    [window addSubview:userInfo];
//    
//}

@end
