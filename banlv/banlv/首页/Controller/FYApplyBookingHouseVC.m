//
//  FYApplyBookingHouseVC.m
//  banlv
//
//  Created by lifeiyang on 16/5/29.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYApplyBookingHouseVC.h"

#import "FYChooseDateView.h"

//发布数据模型
#import "FYApplyBookingHouseData.h"

@interface FYApplyBookingHouseVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet FYChooseDateView *chooseDateView;
@property (weak, nonatomic) IBOutlet UIButton *divBtn;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLab;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UITextView *textFieldView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property (weak, nonatomic) IBOutlet UILabel *introduceYourselfLab;

@property(nonatomic,assign)NSInteger peopleCount;

@property(nonatomic,strong)ZFChooseTimeViewController *chooseDateVC;

@end

@implementation FYApplyBookingHouseVC

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
    
    self.view.frame = kScreenFrame;
    
    __weak typeof(self) mySelf = self;
    
    self.chooseDateView.chooseDateBlock = ^{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            mySelf.chooseDateVC.frame = CGRectMake(0, 0, mySelf.view.width, mySelf.view.height);
        }];
    };
    
    self.chooseDateVC = [[ZFChooseTimeViewController alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, self.view.height)];
    
    
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
    
    //开始判断是否能-
    self.divBtn.enabled = NO;
    [self.divBtn setTitleColor:[UIColor colorWithHexString:@"#D0D0D0"] forState:UIControlStateNormal];
    //开始判断是否能+
    if (self.limitGuestsNum == 1) {
        
        self.plusBtn.enabled = NO;
        [self.plusBtn setTitleColor:[UIColor colorWithHexString:@"#D0D0D0"] forState:UIControlStateNormal];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.textFieldView.delegate = self;
    
    self.introduceYourselfLab.text = [NSString stringWithFormat:@"向%@介绍下你自己",self.ownerName];
    
}

- (NSDate *)getDateFromString:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return [format dateFromString:dateStr];
}

- (void)getSelectDate:(NSMutableArray *)selectDateArr
{
    self.tempChooseDateArr = [selectDateArr mutableCopy];
}

- (void)exitKeyBoard
{
    [self.textFieldView resignFirstResponder];
}

- (IBAction)divAct:(id)sender {
    
    if (self.plusBtn.enabled == NO) {
        
        self.plusBtn.enabled = YES;
        
        [self.plusBtn setTitleColor:[UIColor colorWithRed:0.24 green:0.51 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    }
    
    UIButton *divBtn = (UIButton *)sender;
    
    self.peopleCount--;
    
    self.peopleNumLab.text = [NSString stringWithFormat:@"%ld",self.peopleCount];
    
    if (self.peopleCount == 1) {
        
        divBtn.enabled = NO;
        
        [divBtn setTitleColor:[UIColor colorWithHexString:@"#D0D0D0"] forState:UIControlStateNormal];
    }
}
- (IBAction)plusAct:(id)sender {
    
    NSLog(@"限制人数:%ld",self.limitGuestsNum);
    
    if (self.divBtn.enabled == NO) {
        
        self.divBtn.enabled = YES;
        
        [self.divBtn setTitleColor:[UIColor colorWithRed:0.24 green:0.51 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    }
    
    UIButton *plusBtn = (UIButton *)sender;
    self.peopleCount++;
    
    self.peopleNumLab.text = [NSString stringWithFormat:@"%ld",self.peopleCount];
    
    if (self.peopleCount == self.limitGuestsNum) {
        
        plusBtn.enabled = NO;
        [plusBtn setTitleColor:[UIColor colorWithHexString:@"#D0D0D0"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)decideAct:(id)sender {
    
    FYApplyBookingHouseData *applyBookingHouseData = [FYApplyBookingHouseData mj_objectWithKeyValues:self.publishDic];
    
    BmobObject *gameScore = [BmobObject objectWithClassName:@"OrderForm"];
    [gameScore setObject:applyBookingHouseData.price forKey:@"price"];
    [gameScore setObject:applyBookingHouseData.housePic forKey:@"housePic"];
    [gameScore setObject:applyBookingHouseData.title forKey:@"title"];
    [gameScore setObject:applyBookingHouseData.houseType forKey:@"houseType"];
    [gameScore setObject:[NSString stringWithFormat:@"%@--%@",self.chooseDateView.dateIn.text,self.chooseDateView.dateOut.text] forKey:@"date"];
    [gameScore setObject:self.peopleNumLab.text forKey:@"peopleNum"];
    [gameScore setObject:@"待审核" forKey:@"status"];
    
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        if (isSuccessful) {
            
            NSLog(@"上传成功");
        }
        
        if (error) {
            
            NSLog(@"上传失败:%@",error);
        }
        
    }];
    
    
}

#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@""]) {
        
        if (self.placeHolder.hidden == YES) {
            
            self.placeHolder.hidden = NO;
        }
    }else
    {
        if (self.placeHolder.hidden == NO) {
            
            self.placeHolder.hidden = YES;
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)setOwnerName:(NSString *)ownerName
{
    _ownerName = ownerName;
}

- (void)setpublishDic:(NSMutableDictionary *)publishDic
{
    _publishDic = publishDic;
}

- (void)setLimitGuestsNum:(NSInteger)limitGuestsNum
{
    _limitGuestsNum = limitGuestsNum;
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
