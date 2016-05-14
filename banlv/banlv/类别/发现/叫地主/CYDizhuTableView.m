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

@end

@implementation CYDizhuTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        

        
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
            
            NSArray *jsonArr = [[responseObject objectForKey:@"data"]objectForKey:@"result"];
            NSLog(@"%@",jsonArr);
            [CYDizhuResultData mj_setupObjectClassInArray:^NSDictionary *{
                
                return @{@"pictureList" : @"CYDizhuPictureListData"
                         
                         };
                
            }];
            
            
//            self.dizhuResultData = [CYDizhuResultData mj_objectArrayWithKeyValuesArray:<#(id)#>];
            
            
            [self reloadData];
           
            
            //        self.searchedCityArr = [FYSingleCityData mj_objectArrayWithKeyValuesArray:jsonArr];
            //
            //        //刷新搜索表格
            //        [self.searchedTableView reloadData];
            
            
        } failur:^(NSError *error) {
            
            CYLog(@"error : %@",error);
            
        }];
        

        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  350;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    

    
    
    
    
    static NSString *indentifier = @"CYDizhuCell";
    

    
    
    CYDizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
    
    
        cell = kLoadViewWithNIB(indentifier);
    
    }
    
//    cell.textLabel.text = @"rrrr";
    
    
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
