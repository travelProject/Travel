//
//  BLShareController.m
//  banlv
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLShareController.h"
#import "BLShareTableViewCell.h"

@interface BLShareController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_iconImgArr;
    NSArray *_nameArr;
    
}

@property (weak, nonatomic) IBOutlet UITableView *shareTableView;
@end

@implementation BLShareController
- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
  
}
//隐藏NavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
//退出该控制器时还原,否则会影响到下一级的controlelr
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.shareTableView registerNib:[UINib nibWithNibName:@"BLShareTableViewCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
    self.shareTableView.dataSource = self;
    self.shareTableView.delegate = self;
    self.shareTableView.scrollEnabled = NO;
    _iconImgArr = @[@"recommend_weixin",@"recommend_pengyouquan",@"recommend_QQ",@"recommend_QQspace",@"recommend_weibo"];
    _nameArr = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"新浪微博"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BLShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell" forIndexPath:indexPath];
    cell.iconView.image = [UIImage imageNamed:_iconImgArr[indexPath.row]];
    cell.nameLab.text = _nameArr[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            CYLog(@"分享到微信");
            break;
        case 1:
            CYLog(@"分享到朋友圈");

            break;
        case 2:
            CYLog(@"分享到QQ");

            break;
        case 3:
            CYLog(@"分享到QQ空间");

            break;
        case 4:
            CYLog(@"分享到新浪weibo");

            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
