//
//  CYParCellChildData.h
//  banlv
//
//  Created by lcy on 16/5/22.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYParCellChildData : NSObject

@property (nonatomic, assign) NSInteger ownerId;

@property (nonatomic, copy) NSString *ownerName;

@property (nonatomic, assign) long long birthday;

@property (nonatomic, assign) NSInteger partyStatus;

@property (nonatomic, assign) NSInteger ownerPictureFlag;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger zmAuthentication;

@property (nonatomic, assign) NSInteger partyId;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) CGFloat lng;

@property (nonatomic, assign) long long endTime;

@property (nonatomic, copy) NSString *ownerDescription;

@property (nonatomic, strong) NSArray<NSString *> *joinUserAvatas;

@property (nonatomic, assign) NSInteger limitGuestsNum;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, copy) NSString *ownerPhone;

@property (nonatomic, assign) NSInteger partyUserType;

@property (nonatomic, copy) NSString *joinUserCount;

@property (nonatomic, assign) NSInteger userIdentificationStatus;

@property (nonatomic, strong) NSArray<NSString *> *pics;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) long long startTime;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *description1;

@end
