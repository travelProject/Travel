//
//  CYTableViewData.h
//  banlv
//
//  Created by lcy on 16/5/18.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTableViewData : NSObject

// 添加数据源 + 数据源标签
- (void)addDataArray:(NSArray *)array arrayFlag:(NSString *)flag;

// 对应区域中的row的个数
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

// 有几个section
- (NSInteger)numberOfSections;

// 对应于Section上的flag值标签
- (NSString *)flagInSection:(NSInteger)section;

// 对应于indexPath中的数据
- (id)dataInIndexPath:(NSIndexPath *)indexPath;


@end
