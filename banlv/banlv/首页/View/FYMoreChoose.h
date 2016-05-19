//
//  FYMoreChoose.h
//  banlv
//
//  Created by lfy on 16/5/19.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MoreChoseBlock)();

@interface FYMoreChoose : UILabel

@property (nonatomic,copy) MoreChoseBlock moreChooseBlock;

@end
