//
//  BLOrdersViewController.m
//  伴旅
//
//  Created by scjy on 16/5/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLOrdersViewController.h"

@interface BLOrdersViewController ()

@end

@implementation BLOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:(CGRectMake(0, 0, 300, 30))];
    [segment insertSegmentWithTitle:@"现金账户" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"优惠券" atIndex:1 animated:YES];
//    [segment insertSegmentWithTitle:@"..." atIndex:2 animated:NO];
    segment.selectedSegmentIndex = 0;
//    segment.backgroundColor = [UIColor colorWithHexString:@"#429d96"];
//    segment.tintColor =[UIColor colorWithHexString:@"#429d96"];//tintColor属性很强大
    segment.tintColor = [UIColor colorWithRed:0.45f green:0.77f blue:0.78f alpha:1];
    self.navigationItem.titleView = segment;
    
}

- (void)didselectedSegment:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.view.backgroundColor = [UIColor whiteColor];
            
            break;
        case 1:
             self.view.backgroundColor = [UIColor redColor];
            break;
        case 2:
             self.view.backgroundColor = [UIColor cyanColor];
            break;
            
        default:
            break;
    }
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
