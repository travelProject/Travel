//
//  CYDizhuTableView.m
//  banlv
//
//  Created by lcy on 16/5/8.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "CYDizhuTableView.h"
#import "CYDizhuCell.h"


@interface CYDizhuTableView ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation CYDizhuTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
//        [self registerNib:[UINib nibWithNibName:@"CYDizhuCell" bundle:nil] forCellReuseIdentifier:@"CYDizhuCell"];
        
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 100;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CYDizhuCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
//    }
    
    
    CYDizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
    
    
        cell = kLoadViewWithNIB(indentifier);
    
    }
    
    cell.textLabel.text = @"rrrr";
    
    
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
