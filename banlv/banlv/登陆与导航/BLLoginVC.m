//
//  BLLoginVC.m
//  banlv
//
//  Created by lfy on 16/5/28.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLLoginVC.h"

#import <SMS_SDK/SMSSDK.h>

@interface BLLoginVC ()

@end

@implementation BLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18848962892" zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        
//        if (!error) {
//            NSLog(@"获取验证码成功");
//        } else {
//            NSLog(@"错误信息：%@",error);
//        }
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
