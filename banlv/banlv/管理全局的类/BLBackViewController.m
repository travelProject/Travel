//
//  BLBackViewController.m
//  banlv
//
//  Created by lfy on 16/5/21.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLBackViewController.h"

@interface BLBackViewController ()

@end

@implementation BLBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"fanhui" highlitImageName:nil withAction:@selector(popToVC) target:self itemTitle:nil offset:UIControlContentHorizontalAlignmentLeft];
    
    
}

- (void)popToVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
