//
//  BLLoginVC.m
//  banlv
//
//  Created by lfy on 16/5/28.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLLoginVC.h"

#import <SMS_SDK/SMSSDK.h>

@interface BLLoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconPic;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *getCodeLab;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UILabel *voiceLab;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@end

@implementation BLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.iconPic.layer.cornerRadius = 10.f;
    self.iconPic.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *getCodeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeAct)];
    
    self.getCodeLab.userInteractionEnabled = YES;
    
    [self.getCodeLab addGestureRecognizer:getCodeTap];
    
    UITapGestureRecognizer *exitKeyBoardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard)];
    
    [self.view addGestureRecognizer:exitKeyBoardTap];
    
    self.phoneText.delegate = self;
    self.codeText.delegate = self;
    
    

    
}

- (void)getCodeAct
{
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
        
    }];
}

- (void)exitKeyBoard
{
    [self.phoneText resignFirstResponder];
    
    [self.codeText resignFirstResponder];
}

- (IBAction)startBtnAct:(id)sender {
}
- (IBAction)exitBtnAct:(id)sender {
}

#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
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
