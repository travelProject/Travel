//
//  FYAFNetworking.h
//  banlv
//
//  Created by lfy on 16/5/10.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYAFNetworkingManager : AFHTTPSessionManager

+ (instancetype)manager;

- (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(void(^)(id responseObject))success failur:(void(^)(NSError *error))failure;

- (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(void(^)(id responseObject))success failur:(void(^)(NSError *error))failure;

@end
