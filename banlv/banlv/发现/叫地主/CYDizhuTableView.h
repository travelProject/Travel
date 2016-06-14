//
//  CYDizhuTableView.h
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectRowBlock)(NSInteger);

typedef void(^xuanfu)(UIButton *xuanfuBtn);

typedef void(^xuanfuH)();
typedef void(^xuanfuS)();

@interface CYDizhuTableView : UITableView
@property(nonatomic, copy)xuanfu xuanfuBtn;
@property(nonatomic, copy)xuanfuH xuanfuH;
@property(nonatomic, copy)xuanfuS xuanfuS;

@property (nonatomic ,copy)SelectRowBlock selectRowBlock;

@end
