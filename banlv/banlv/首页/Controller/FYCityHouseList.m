//
//  FYCityHouseList.m
//  banlv
//
//  Created by lifeiyang on 16/5/13.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseList.h"

@interface FYCityHouseList ()

@property(nonatomic,strong) UITableView *houseListTableView;

@end

@implementation FYCityHouseList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
}

- (void)initTableView
{
    
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
