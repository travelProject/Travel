//
//  AppDelegate.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "AppDelegate.h"
#import "CYTabBarController.h"

//短信验证码
#import <SMS_SDK/SMSSDK.h>

//导航图片
#import "BLScrollView.h"


@interface AppDelegate ()

{
    BMKMapManager * _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bmob registerWithAppKey:@"96670d94525fd56d34affb410c010ef5"];
    
    
    [SMSSDK registerApp:@"134293659e2b6" withSecret:@"9ef80f31fe000f5471c2f62e0a850ab3"];
    
    // 要使用百度地图，请先启动BaiduMapManager 
    _mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [_mapManager start:@"rRHanAe9IfoeT4VpDFAEHSwCpGBVcMic"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    CYTabBarController *tabBar = [[CYTabBarController alloc]init];
    
    self.window.rootViewController = tabBar;

    [self.window makeKeyAndVisible];
    
//    BLScrollView *scrollView = [[BLScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window.rootViewController.view addSubview:scrollView];
    

//    NSString *key = @"CFBundleShortVersionString";
//    
//    
//    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
//    
//    NSString *value = dict[key];
//    
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    //判断是否是第一次打开
//    NSString *valueStr  = [userDefaults stringForKey:key];
//    
//    if (![value isEqualToString:valueStr]) {
//        //第一次打开
//        
//        YLGuideView *guideView = [YLGuideView guideView];
//        
//        [self.window.rootViewController.view addSubview:guideView];
//        
//        [userDefaults setObject:value forKey:key];
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
