//
//  SearchViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "SearchViewController.h"

//选择城市
#import "FYLookMoreCityVC.h"

//列表模式
#import "FYCityHouseListVC.h"

//地图模式
#import "FYCityHouseMapVC.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *listStyle;
@property (weak, nonatomic) IBOutlet UIButton *mapStyle;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    
}
- (IBAction)chooseCity:(id)sender {
    
    FYLookMoreCityVC *chooseCityVC = [[FYLookMoreCityVC alloc] init];
    chooseCityVC.flag = NO;
    
    chooseCityVC.selectedIdBlock = ^(NSString *cityId,NSString *cityName){
    
        self.cityId = cityId;
        
        self.cityName = cityName;
    };
    
    [self.navigationController pushViewController:chooseCityVC animated:YES];
    
}
- (IBAction)chooseDate:(id)sender {
    
    NSLog(@"选择日期");
}
- (IBAction)listStyleAction:(id)sender {
    
    self.mapStyle.selected = NO;
    self.listStyle.selected = !self.listStyle.isSelected;
}
- (IBAction)mapStyleAction:(id)sender {
    
    self.listStyle.selected = NO;
    self.mapStyle.selected = !self.mapStyle.isSelected;
}
- (IBAction)searchHouseAction:(id)sender {
    
    NSLog(@"进行搜索");
    
    if (self.listStyle.selected) {
        
        FYCityHouseListVC *cityHouseListVC = [[FYCityHouseListVC alloc] init];
        cityHouseListVC.cityId = self.cityId;
        cityHouseListVC.cityName = self.cityName;
        
        [self.navigationController pushViewController:cityHouseListVC animated:YES];
        
    }else if (self.mapStyle.selected)
    {
        FYCityHouseMapVC *cityHouseMapVC = [[FYCityHouseMapVC alloc] init];
        cityHouseMapVC.cityId = self.cityId;
        cityHouseMapVC.cityName = self.cityName;
        
        [self.navigationController pushViewController:cityHouseMapVC animated:YES];
        
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
