//
//  CYDizhuTableView.m
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDizhuTableView.h"
#import "CYDizhuCell.h"

#import "CYDizhuData.h"
#import "CYDizhuResultData.h"


@interface CYDizhuTableView ()<UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic ,strong)CYDizhuResultData *dizhuResultData;

@property(nonatomic, strong)NSArray<CYDizhuResultData *> *dataArr;

@end

@implementation CYDizhuTableView

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc] init];
    }
    return _dataArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self request];

        
       
        

        
    }
    return self;
}


- (void)request{
    NSString *search = nil;
    
    FYAFNetworkingManager *manager = [FYAFNetworkingManager manager];
    
    NSString *params = [NSString stringWithFormat:@"bizParams={\n\"key\":\"%@\",\n\"userToken\":\"MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2\"\n}",search];
    
    NSString *urlStr = @"http://www.shafalvxing.com/channel/getLocalServiceList.do?";
    //http://www.shafalvxing.com/channel/getLocalServiceList.do
    //    bizParams：{
    //          "userToken" : "MDM5ZmM2MTVlMDY2MWJiZDhjNTVlNmQ0OThiY2VjOTlhNmU4M2YyYjQyNGNhMmQ2",
    //          "page" : 1
    //    }
    
    [manager GET:[urlStr encodeURLWithParams:params] parameters:nil success:^(id responseObject) {
        
//        NSLog(@"%@",[urlStr encodeURLWithParams:params]);
        
        //            NSLog(@"%@",responseObject);
        
        NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
//        NSLog(@"%@",jsonArr);
//        [CYDizhuResultData mj_setupObjectClassInArray:^NSDictionary *{
//            
//            return @{@"pictureList" : @"CYDizhuPictureListData"
//                     
//                     };
//            
//        }];
        
        self.dataArr = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:jsonArr];
        
        
        //            self.dizhuResultData = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:<#(id)#>];
        
        
        [self reloadData];
        
        
    } failur:^(NSError *error) {
        
        NSLog(@"error : %@",error);
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  350;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    
    return self.dataArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    

    
    
    
    
    static NSString *indentifier = @"CYDizhuCell";
    

    
    
    CYDizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = kLoadViewWithNIB(indentifier);
    
    }
    
    NSString  *gender = nil;
    if ([self.dataArr[indexPath.row].sex isEqualToString:@"1"]) {
        gender = @"男";
    }else{
        gender =@"女";
    }
    
    
    
    NSString *jianjie = [NSString stringWithFormat:@"%@岁  %@  %@",self.dataArr[indexPath.row].age,gender,self.dataArr[indexPath.row].profession];
    
    
    
    
    
    cell.jianjie.text =jianjie;
    
    NSString *serve1 = nil;
    NSString *serve2 = nil;
    if (self.dataArr[indexPath.row].serviceNameList.count ==1) {
        serve1 =self.dataArr[indexPath.row].serviceNameList[0];
    }else if (self.dataArr[indexPath.row].serviceNameList.count ==2){
        serve1 =self.dataArr[indexPath.row].serviceNameList[0];
         serve2 = self.dataArr[indexPath.row].serviceNameList[1];
    }
    
    cell.serve1.text = serve1;
    
    cell.serve2.text = serve2;
    

    cell.jiage.text =[NSString stringWithFormat:@"%@/天 ",self.dataArr[indexPath.row].price];
    cell.userName.text = self.dataArr[indexPath.row].ownerName;
    
    
    
    NSLog(@"%@",self.dataArr[indexPath.row].pictureList[0]);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row].pictureList[0]];
    
    
    [cell.bgImg sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
    return cell;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
