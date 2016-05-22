//
//  CYPartyTableView.h
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef void(^PartyIdBlock)(NSString *row);

@interface CYPartyTableView : UITableView



@property (nonatomic ,copy)PartyIdBlock partyIdBlock;





@end
