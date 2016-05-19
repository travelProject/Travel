//
//  CYTableViewData.m
//  banlv
//
//  Created by lcy on 16/5/18.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYTableViewData.h"

@interface CYTableViewData ()

@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) NSMutableArray  *nameList;

@end
@implementation CYTableViewData


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _dataArray = [NSMutableArray new];
        _nameList  = [NSMutableArray new];
    }
    return self;
}

- (void)addDataArray:(NSArray *)array arrayFlag:(NSString *)flag
{
    [_dataArray addObject:array];
    [_nameList  addObject:flag];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (NSInteger)numberOfSections
{
    return [_dataArray count];
}

- (NSString *)flagInSection:(NSInteger)section
{
    return _nameList[section];
}

- (id)dataInIndexPath:(NSIndexPath *)indexPath
{
    return _dataArray[indexPath.section][indexPath.row];
}

@end
