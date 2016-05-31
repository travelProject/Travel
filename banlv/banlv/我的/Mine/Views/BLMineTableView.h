//
//  BLMineTableView.h
//  banlv
//
//  Created by scjy on 16/5/22.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectRowBlock)(NSInteger);
@interface BLMineTableView : UIView
@property(nonatomic,copy) SelectRowBlock selectRowBlock;
@end
