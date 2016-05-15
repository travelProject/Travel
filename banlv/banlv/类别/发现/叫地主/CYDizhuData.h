//
//  CYDizhuData.h
//  banlv
//
//  Created by lcy on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYDizhuResultData.h"
@interface CYDizhuData : NSObject

@property(nonatomic ,strong)NSNumber *currentPage;
@property(nonatomic ,strong)NSNumber *pageSize;
@property(nonatomic,strong)NSArray<CYDizhuResultData *> *result;
@property(nonatomic,strong)NSNumber *totalNum;

@property(nonatomic,strong)NSNumber *totalPageNum;


@end
