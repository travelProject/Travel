//
//  ZFChooseTimeViewController.h
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnDateBlock)(NSMutableArray *dateArr);

/**
 *  时间选择器
 */
@interface ZFChooseTimeViewController : UIView

@property (nonatomic,copy)ReturnDateBlock returnDateBlock;

@property(nonatomic,strong)NSMutableArray *selectedDateArr;

@end
