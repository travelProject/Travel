//
//  BLFeedbackController.m
//  伴旅
//
//  Created by scjy on 16/5/15.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "BLFeedbackController.h"

@interface BLFeedbackController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *issuesView;

@end

@implementation BLFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"意见反馈";
    if(iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.issuesView.delegate = self;
    self.issuesView.font = [UIFont systemFontOfSize:18];
    self.issuesView.returnKeyType = UIReturnKeySend;
    //控制键盘return健是否可以点击，如果为YES，当没有输入的时候，是不能够被点击的
    self.issuesView.enablesReturnKeyAutomatically = YES;

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
   
}
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.issuesView.text isEqualToString:@"请简单描述你遇到的问题"]) {
        self.issuesView.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [_issuesView resignFirstResponder];
        return NO;
    }
    return YES;
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.issuesView.text.length <1) {
        self.issuesView.text = @"请简单描述你遇到的问题";
    }
 
    NSLog(@"发送数据成功%@", _issuesView.text);
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
