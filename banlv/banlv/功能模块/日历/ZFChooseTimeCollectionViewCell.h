//
//  ZFChooseTimeCollectionViewCell.h
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//


#define CYBColorGreen [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define YJCorl(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface ZFChooseTimeCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) NSArray *dateForCell;

@property(nonatomic,strong) NSArray *currentDate;

@property (weak, nonatomic) IBOutlet UILabel *number;

/**
 *  更新布局
 *
 *  @param number   cell代表时间
 *  @param newArray 出团时间
 */
- (void)updateDay:(NSArray*)number currentDate:(NSArray*)newArray;


@end
