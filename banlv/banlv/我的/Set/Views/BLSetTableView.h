//
//  BLSetTableView.h
//  banlv
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectRowBlock)(NSInteger);

@interface BLSetTableView : UIView

@property(nonatomic,copy) SelectRowBlock selectRowBlock;

@end
