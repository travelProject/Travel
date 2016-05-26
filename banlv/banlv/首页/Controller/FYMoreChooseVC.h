//
//  FYMoreChooseVC.h
//  banlv
//
//  Created by lfy on 16/5/19.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnMoreChooses)(NSInteger limitGuestsNum,NSInteger sex,NSMutableArray *spaceTypes,CGFloat startPrice,CGFloat endPrice,NSMutableArray *tempChooseDateArr,NSString *dateIn,NSString *dateOut);

@interface FYMoreChooseVC : BLBackViewController

@property(nonatomic,strong)NSMutableArray *selectDateArr;

@property(nonatomic,assign) NSInteger limitGuestsNum;

@property(nonatomic,strong) NSMutableArray *spaceTypes;

@property(nonatomic,assign) NSInteger sex;

@property(nonatomic,assign) CGFloat startPrice;

@property(nonatomic,assign) CGFloat endPrice;

@property(nonatomic,strong) NSMutableArray *tempChooseDateArr;

@property(nonatomic,copy) ReturnMoreChooses returnMoreChooses;

@end
