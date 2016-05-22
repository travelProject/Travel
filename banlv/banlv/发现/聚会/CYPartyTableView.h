//
//  CYPartyTableView.h
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//


typedef void(^SelectRowBlock)(NSInteger);
#import <UIKit/UIKit.h>

@interface CYPartyTableView : UITableView



@property (nonatomic ,copy)SelectRowBlock partyRow;





@end
