//
//  FYApplyBookingHouseVC.m
//  banlv
//
//  Created by lifeiyang on 16/5/29.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYApplyBookingHouseVC.h"

#import "FYChooseDateView.h"

@interface FYApplyBookingHouseVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet FYChooseDateView *chooseDateView;
@property (weak, nonatomic) IBOutlet UIButton *divBtn;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLab;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UITextView *textFieldView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property (weak, nonatomic) IBOutlet UILabel *introduceYourselfLab;

@end

@implementation FYApplyBookingHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame = kScreenFrame;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.textFieldView.delegate = self;
    
    self.introduceYourselfLab.text = [NSString stringWithFormat:@"向%@介绍下你自己",self.ownerName];
    
}

- (void)exitKeyBoard
{
    [self.textFieldView resignFirstResponder];
}

- (IBAction)divAct:(id)sender {
}
- (IBAction)plusAct:(id)sender {
}
- (IBAction)decideAct:(id)sender {
    
    
    //往GameScore表添加一条playerName为小明，分数为78的数据
//    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
//    [gameScore setObject:@"小明" forKey:@"playerName"];
//    [gameScore setObject:@78 forKey:@"score"];
//    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
//    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        //进行操作
//    }];
    
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
