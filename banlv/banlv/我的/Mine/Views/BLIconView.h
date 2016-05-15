//
//  BLUserInfoView.h
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLIconView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
+(id)loadView;
@end
