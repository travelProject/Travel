//
//  FYAFNetworking.m
//  banlv
//
//  Created by lfy on 16/5/10.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYAFNetworkingManager.h"

@implementation FYAFNetworkingManager

+ (instancetype)manager
{
    return [[self alloc] init];
}

kSharedObjWithClass;

- (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(void(^)(id responseObject))success failur:(void(^)(NSError *error))failure
{
    
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

- (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(void(^)(id responseObject))success failur:(void(^)(NSError *error))failure
{
    
    [self POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}


@end
