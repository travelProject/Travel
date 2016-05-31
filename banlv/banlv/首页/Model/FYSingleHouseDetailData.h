//
//  FYSingleHouseDetailData.h
//  banlv
//
//  Created by lfy on 16/5/26.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYSingleHouseDetailData : NSObject

@property(nonatomic,copy) NSString *title;//标题

@property(nonatomic,copy) NSString *ownerPic;

@property(nonatomic,copy) NSString *ownerName;

@property(nonatomic,copy) NSString *age;

@property(nonatomic,copy) NSString *price;

@property(nonatomic,copy) NSString *sex;

@property(nonatomic,copy) NSString *ownerDescription;

@property(nonatomic,copy) NSString *profession;

@property(nonatomic,copy) NSString *descrip;//共享空间详情

@property(nonatomic,copy) NSString *spaceType;

@property(nonatomic,copy) NSString *sexLimit;//性别要求

@property(nonatomic,copy) NSString *limitGuestsNum;//最多入住人数

@property(nonatomic,copy) NSString *limitNightsNum;//可租天数

@property(nonatomic,copy) NSString *reviewScore;//评分


@property(nonatomic,copy) NSString *lat;
@property(nonatomic,copy) NSString *lng;

@property(nonatomic,copy) NSString *address;//地址

@end
