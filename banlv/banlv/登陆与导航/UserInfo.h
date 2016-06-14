//
//  UserInfo.h
//  banlv
//
//  Created by lifeiyang on 16/6/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *realname;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *email;
@property(nonatomic,copy) NSString *logo;

+ (instancetype)sharedUserInfo;

@end
