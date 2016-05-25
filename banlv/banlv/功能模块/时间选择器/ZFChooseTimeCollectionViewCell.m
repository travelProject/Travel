//
//  ZFChooseTimeCollectionViewCell.m
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#define CYBColorGreen [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define YJCorl(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#import "ZFChooseTimeCollectionViewCell.h"

@implementation ZFChooseTimeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code

}


//number每月每一天数组  newArray当前日期
- (void)updateDay:(NSArray*)number currentDate:(NSArray*)newArray;
{

    NSInteger p_1 =[newArray componentsJoinedByString:@""].intValue;//当前日期
    
    NSInteger p_2 =[number componentsJoinedByString:@""].intValue;//每月每一天
    
    int num = [number[2] intValue];
    
    if (num>0) {
        
        if (p_1>p_2){
            
            self.number.backgroundColor = [UIColor whiteColor];
            self.number.textColor = [UIColor colorWithHexString:@"#D5D5D5"];
            self.userInteractionEnabled = NO;
            
        }else if (p_1 == p_2)
        {
            self.number.backgroundColor = [UIColor whiteColor];
            self.number.textColor =[UIColor colorWithHexString:@"##78CFD2"];
            self.userInteractionEnabled = YES;
            
        }else{
            
            self.number.backgroundColor = [UIColor whiteColor];
            self.number.textColor =[UIColor colorWithHexString:@"#606060"];
            self.userInteractionEnabled = YES;
        }
        
    }else{//空白处（小于0就显示为白色，和背景色一样）
        
        self.number.backgroundColor = [UIColor whiteColor];
        self.number.textColor =[UIColor whiteColor];
        self.userInteractionEnabled = NO;
    }
    
    
    if (num>=10) {
        
     self.number.text = [NSString stringWithFormat:@"%@",number[2]];
        
    }else{
    
     NSString*str =[NSString stringWithFormat:@"%@",number[2]];
        
     //小于10的去掉前面的0
      self.number.text = [str stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }


}

- (void)setDateForCell:(NSArray *)dateForCell
{
    _dateForCell = dateForCell;
}

- (void)setCurrentDate:(NSArray *)currentDate
{
    _currentDate = currentDate;
    
    [self updateDay:self.dateForCell currentDate:_currentDate];
}


@end



