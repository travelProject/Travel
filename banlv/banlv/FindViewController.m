//
//  FindViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FindViewController.h"
#import "CYPartyViewController.h"
#import "CYCallViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"发现"];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *callBtn = [[UIButton alloc] init];
    
    callBtn.frame = CGRectMake(0, 44 + 10, kScreenFrameW, 200);
    
    callBtn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:callBtn];
    
    [callBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *partyBtn = [[UIButton alloc] init];
    
    partyBtn.frame = CGRectMake(0,44 + 210, kScreenFrameW, 200);
    
    partyBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:partyBtn];
    
    [partyBtn addTarget:self action:@selector(party:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
}

- (void)call:(id)sender{
    CYCallViewController *newvc = [[CYCallViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newvc];
    
    
    
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
    
}

- (void)party:(id)sender{
    CYPartyViewController *newvc = [[CYPartyViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newvc];
    
    
    
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
