//
//  FYCityHouseListData.h
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYCityHouseListData : NSObject

@property(nonatomic,copy) NSString *spaceId;//房间ID

@property(nonatomic,strong) NSArray *pictureList;//轮播图片数组

@property(nonatomic,copy) NSString *collectionStatus;//收藏状态（收藏❤️）

@property(nonatomic,copy) NSString *districtName;//闵行区
@property(nonatomic,copy) NSString *spaceType;//房间类型（1.客厅沙发 2.合租放假 榻榻米 3.独立房间 双人床）

@property(nonatomic,copy) NSString *price;//价格
@property(nonatomic,copy) NSString *title;//价格右侧标题

@property(nonatomic,copy) NSString *ownerName;//房东名字
@property(nonatomic,copy) NSString *ownerPic;//房东头像

@property(nonatomic,copy) NSString *userIdentificationStatus;//实名认证状态（2:认证）
@property(nonatomic,copy) NSString *zmAuthentication;//芝麻认证状态(1:认证)

@property(nonatomic,copy) NSString *reviewScore;//评论星级(千万不能用int,不是对象，不能key-value赋值)

@property(nonatomic,copy) NSString *reviewAmount;//评价数量

@property(nonatomic,copy) NSString *replyRate;//回复率

@property(nonatomic,copy) NSString *lat;//纬度

@property(nonatomic,copy) NSString *lng;//经度

@property(nonatomic,copy) NSString *cityName;//城市名称




@end
