//
//  FYMoreChooseVC.m
//  banlv
//
//  Created by lfy on 16/5/19.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYMoreChooseVC.h"

@interface FYMoreChooseVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewH;

@end

@implementation FYMoreChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.scrollViewH.constant = self.view.height;
}

@end
