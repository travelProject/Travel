//
//  FYMoreChooseVC.m
//  banlv
//
//  Created by lfy on 16/5/19.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYMoreChooseVC.h"

//选择日期类
#import "FYChooseDateView.h"

@interface FYMoreChooseVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewH;
@property (weak, nonatomic) IBOutlet UIView *choosePeopleNum;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *HostSex;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLimmit;

@property(nonatomic,strong)NSArray *sexArr;
@property (weak, nonatomic) IBOutlet FYChooseDateView *chooseDateView;

@property(nonatomic,strong)ZFChooseTimeViewController *chooseDateVC;

@property(nonatomic,assign) NSUInteger sexCount;
@property (weak, nonatomic) IBOutlet UIButton *divBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

@property(nonatomic,assign)NSInteger peopleCount;

@property (weak, nonatomic) IBOutlet UISlider *priceSlideBar;


@end

@implementation FYMoreChooseVC


- (NSInteger)limitGuestsNum
{
    if (!_limitGuestsNum) {
        
        _limitGuestsNum = 0;
    }
    
    return _limitGuestsNum;
}

- (NSMutableArray *)spaceTypes
{
    if (!_spaceTypes) {
        
        _spaceTypes = [NSMutableArray array];
    }
    
    return _spaceTypes;
}

- (NSInteger)sex
{
    if (!_sex) {
        
        _sex = 0;
    }
    
    return _sex;
}

- (CGFloat)startPrice
{
    if (!_startPrice) {
        
        _startPrice = 0.0;
    }
    
    return _startPrice;
}

- (CGFloat)endPrice
{
    if (!_endPrice) {
        
        _endPrice = 199.9;
    }
    
    return _endPrice;
}

- (NSMutableArray *)selectDateArr
{
    if (!_selectDateArr) {
        
        _selectDateArr = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    }
    
    return _selectDateArr;
}


- (NSDate *)getDateFromString:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return [format dateFromString:dateStr];
}

- (NSArray *)sexArr
{
    if (!_sexArr) {
        
        _sexArr = [NSArray arrayWithObjects:@"男", @"男女不限" ,@"女" ,nil];
    }
    
    return _sexArr;
}

- (NSUInteger)sexCount
{
    if (!_sexCount) {
        
        _sexCount = 100;
        
    }
    return _sexCount;
}

- (NSInteger)peopleCount
{
    if (!_peopleCount) {
        
        _peopleCount = 1;
    }
    return _peopleCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.divBtn.enabled = NO;
    [self.divBtn setTitleColor:[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0] forState:UIControlStateNormal];
    
    self.priceSlideBar.tintColor = [UIColor colorWithHexString:@"#079FA1"];
    
    [self.priceSlideBar addTarget:self action:@selector(sliderDragUp) forControlEvents:UIControlEventTouchUpInside];
    
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
        
        mySelf.chooseDateView.dateIn.text = dateInStr;
        mySelf.chooseDateView.dateOut.text = dateOutStr;
        
        [mySelf.selectDateArr removeAllObjects];
        
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveIn]];
        [mySelf.selectDateArr addObject:[NSString stringWithFormat:@"%ld",liveOut]];
        
        [mySelf getSelectDate:mySelf.selectDateArr];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseDateVC];

    
    self.chooseDateView.chooseDateBlock = ^{
        
        mySelf.chooseDateVC.frame = CGRectMake(0, 0, mySelf.view.width, mySelf.view.height);
    };
}

- (void)getSelectDate:(NSMutableArray *)selectDateArr
{
    self.tempChooseDateArr = [selectDateArr mutableCopy];
}

- (void)sliderDragUp
{
    self.endPrice = self.priceSlideBar.value * 199.9;
    
    
}


- (IBAction)leftArrow:(id)sender {
    
    self.sexCount--;
    
    self.HostSex.text = self.sexArr[self.sexCount % 3];
    
}
- (IBAction)rightArrow:(id)sender {
    
    self.sexCount += 1;
    
    self.HostSex.text = self.sexArr[self.sexCount % 3];
 
}
- (IBAction)divBtn:(id)sender {
    
    if (self.plusBtn.enabled == NO) {
        
        self.plusBtn.enabled = YES;
        
        [self.plusBtn setTitleColor:[UIColor colorWithRed:0.24 green:0.51 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    }
    
    UIButton *divBtn = (UIButton *)sender;
    
    self.peopleCount--;
    
    self.peopleNumLimmit.text = [NSString stringWithFormat:@"%ld",self.peopleCount];
    
    if (self.peopleCount == 1) {
        
        divBtn.enabled = NO;
        
        [divBtn setTitleColor:[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0] forState:UIControlStateNormal];
    }
    
}

- (IBAction)plusBtn:(id)sender {
    
    if (self.divBtn.enabled == NO) {
        
        self.divBtn.enabled = YES;
        
        [self.divBtn setTitleColor:[UIColor colorWithRed:0.24 green:0.51 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    }
    
    UIButton *divBtn = (UIButton *)sender;
    self.peopleCount++;
    
    self.peopleNumLimmit.text = [NSString stringWithFormat:@"%ld",self.peopleCount];
    
    if (self.peopleCount == 4) {
        
        divBtn.enabled = NO;
        [divBtn setTitleColor:[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0] forState:UIControlStateNormal];
    }
    
}
- (IBAction)sapceType1:(id)sender {
    
    [self.spaceTypes addObject:@"1"];
}
- (IBAction)spaceType2:(id)sender {
    
    [self.spaceTypes addObject:@"2"];
}
- (IBAction)spaceType3:(id)sender {
    
    [self.spaceTypes addObject:@"3"];
}

- (IBAction)searchWithChooseAct:(id)sender {
    
 
    if ([self.HostSex.text isEqualToString:@"女"]) {
        
        self.sex = 1;
    }else if ([self.HostSex.text isEqualToString:@"男"])
    {
        self.sex = 2;
    }
    
    self.returnMoreChooses(self.peopleCount,self.sex,self.spaceTypes,self.startPrice,self.endPrice,self.tempChooseDateArr,self.chooseDateView.dateIn.text,self.chooseDateView.dateOut.text);
  
//    NSLog(@"选择的日期:%@",self.tempChooseDateArr);
//    NSLog(@"房主男女:%ld",self.sex);
//    NSLog(@"入住人数:%ld",self.peopleCount);
//    NSLog(@"房源类型:%@",self.spaceTypes);
//    NSLog(@"初始价格为%f",self.startPrice);
//    NSLog(@"结束价格为%f",self.endPrice);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.scrollViewH.constant = CGRectGetMaxY(self.choosePeopleNum.frame) + self.searchBtn.height + 5;
}

@end
