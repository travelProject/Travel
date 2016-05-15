//
//  BLTempController.m
//  伴旅
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLTempController.h"
#import "BLSetController.h"
#import "BLMineViewController.h"
@interface BLTempController ()

@end

@implementation BLTempController


- (instancetype)init
{
    self = [super init];
    if (self) {
        BLSetController *set = [[BLSetController alloc] init];
        
        BLMineViewController *mine = [[BLMineViewController alloc] init];
        
        self = [[BLTempController alloc] initWithCenterViewController:mine rightDrawerViewController:set];
//        //    打开手势
        self.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
        self.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
//        [self setShowsShadow:NO];
        
        
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
