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
@property (weak, nonatomic) IBOutlet UIView *choosePeopleNum;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *HostSex;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLimmit;

@property(nonatomic,strong)NSArray *sexArr;

@property(nonatomic,assign) NSUInteger sexCount;
@property (weak, nonatomic) IBOutlet UIButton *divBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

@property(nonatomic,assign)NSInteger peopleCount;

@end

@implementation FYMoreChooseVC

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
    
    self.divBtn.enabled = NO;
    [self.divBtn setTitleColor:[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0] forState:UIControlStateNormal];
}
- (IBAction)chooseHouseLocation:(id)sender {
    
    NSLog(@"选择房源");
    
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
    NSLog(@"减的数量:%ld",self.peopleCount);
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
    
    NSLog(@"加的数量:%ld",self.peopleCount);
    self.peopleNumLimmit.text = [NSString stringWithFormat:@"%ld",self.peopleCount];
    
    if (self.peopleCount == 4) {
        
        divBtn.enabled = NO;
        [divBtn setTitleColor:[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.scrollViewH.constant = CGRectGetMaxY(self.choosePeopleNum.frame) + self.searchBtn.height + 5;
}

@end
