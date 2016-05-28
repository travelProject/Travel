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

@property(nonatomic,strong)ZFChooseTimeViewController *chooseDateVC;

@end

@implementation SearchViewController

- (NSMutableArray *)selectDateArr
{
    if (!_selectDateArr) {
        
        _selectDateArr = [NSMutableArray array];
    }
    
    return _selectDateArr;
}

- (NSDate *)getDateFromString:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return [format dateFromString:dateStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.searchBtn.layer.cornerRadius = 10.f;
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.borderColor = [UIColor colorWithHexString:@"#58BBBB"].CGColor;
    self.searchBtn.layer.borderWidth = 1.f;
    
    self.chooseDateVC = [[ZFChooseTimeViewController alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, self.view.height)];
    
    __weak typeof(self) mySelf = self;
    
    self.chooseDateVC.returnDateBlock = ^(NSMutableArray *selectedDateArr)
    {
        mySelf.selectDateArr = selectedDateArr;
        
        NSString *dateInStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[0][0],mySelf.selectDateArr[0][1],mySelf.selectDateArr[0][2]];
        NSDate *dateIn = [mySelf getDateFromString:dateInStr];
        
        NSInteger liveIn = (NSInteger)[dateIn timeIntervalSince1970];
        
        NSString *dateOutStr = [NSString stringWithFormat:@"%@-%@-%@",mySelf.selectDateArr[1][0],mySelf.selectDateArr[1][1],mySelf.selectDateArr[1][2]];
        NSDate *dateOut = [mySelf getDateFromString:dateOutStr];
        
        NSInteger liveOut = (NSInteger)[dateOut timeIntervalSince1970];
        
//        mySelf.chooseDateView.dateIn.text = dateInStr;
//        mySelf.chooseDateView.dateOut.text = dateOutStr;
        
        [mySelf.selectDateArr removeAllObjects];
        
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveIn]];
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveOut]];
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseDateVC];
    
}

- (void)getSelectDate:(NSMutableArray *)selectDateArr
{
    self.tempChooseDateArr = [selectDateArr mutableCopy];
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
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.chooseDateVC.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    }];
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
    
    if (!self.cityId&&!self.tempChooseDateArr) {
        
        return;
    }
    
    
    if (self.listStyle.selected) {
        
        FYCityHouseListVC *cityHouseListVC = [[FYCityHouseListVC alloc] init];
        cityHouseListVC.cityId = self.cityId;
        cityHouseListVC.cityName = self.cityName;
        cityHouseListVC.tempChooseDateArr = self.self.tempChooseDateArr;
        
        [self.navigationController pushViewController:cityHouseListVC animated:YES];
        
    }else if (self.mapStyle.selected)
    {
        FYCityHouseMapVC *cityHouseMapVC = [[FYCityHouseMapVC alloc] init];
        cityHouseMapVC.cityId = self.cityId;
        cityHouseMapVC.cityName = self.cityName;
        cityHouseMapVC.tempChooseDateArr = self.self.tempChooseDateArr;
        
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
