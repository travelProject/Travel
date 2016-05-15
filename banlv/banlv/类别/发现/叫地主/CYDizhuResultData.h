//
//  CYDizhuResultData.h
//  banlv
//
//  Created by lcy on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYDizhuPictureListData.h"

@interface CYDizhuResultData : NSObject

@property(nonatomic,strong)NSNumber *age;

@property(nonatomic,strong)NSNumber *cityId;

@property(nonatomic,copy)NSString *cityName;

@property(nonatomic,copy)NSString *country;

@property(nonatomic,strong)NSNumber *countryId;

@property(nonatomic,strong)NSNumber *localServiceId;

@property(nonatomic,strong)NSNumber *ownerId;

@property(nonatomic,copy)NSString *ownerName;


@property(nonatomic,strong)NSArray<CYDizhuPictureListData *> *pictureList;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *profession;

@property(nonatomic,strong)NSArray *serviceNameList;

@property(nonatomic,strong)NSNumber *sex;

@property(nonatomic,strong)NSNumber *userIdentificationStatus;

@property(nonatomic,strong)NSNumber *zmAuthentication;

@property(nonatomic,copy)NSString *zmRank;









@end
