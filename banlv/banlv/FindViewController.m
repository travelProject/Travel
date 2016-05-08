//
//  FindViewController.m
//  banlv
//
//  Created by lcy on 16/5/6.
//  Copyright © 2016年 llz. All rights reserved.
//

#define kSegmentH 30

#define kTableViewY 64

#import "FindViewController.h"
#import "CYSegment.h"

#import "CYMainTableView.h"
#import "CYDizhuTableView.h"
#import "CYPartyTableView.h"


#import "UIView+frame.h"

@interface FindViewController ()
@property(nonatomic, strong)NSMutableArray *reuseTableViews;

@property(nonatomic, strong)CYSegment *segment;

@property(nonatomic, strong)CYDizhuTableView *dizhuTableView;
@property(nonatomic, strong)CYPartyTableView *partyTableView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"发现"];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    NSArray *arrItems = @[@"叫地主",@"聚会"];
    
    CYSegment *segment = [[CYSegment alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 30) withItems:arrItems];
    
    segment.segmentBgColor = [UIColor whiteColor];
    
    segment.defaultPerColor = [UIColor blackColor];
    
    segment.perColor = [UIColor redColor];
    
    segment.underLayerBackgroudColor = [UIColor redColor];
    
    segment.selectIdx = 0;
    
    [self.view addSubview:segment];
    
    self.segment = segment;
    
    if (segment.selectIdx ==0) {
        self.dizhuTableView = [self creatDizhuTableView];
    }else{
        self.partyTableView = [self creaPartyTableView];
    }
    
    
    
}

- (NSMutableArray *)reuseTableViews{
    if (!_reuseTableViews) {
        _reuseTableViews = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _reuseTableViews;
}

- (CYDizhuTableView *)creatDizhuTableView{
    CYDizhuTableView *dizhu = nil;
    
    
    if (self.reuseTableViews.count > 0) {
        dizhu = [self.reuseTableViews lastObject];
        [self.reuseTableViews removeLastObject];
    }else{
        dizhu = [[CYDizhuTableView alloc] initWithFrame:CGRectMake(0, kTableViewY + kSegmentH, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY - kSegmentH) style:UITableViewStylePlain];
        
        
        
        [self.view addSubview:dizhu];
    }

    
    
    
    return dizhu;
    
}


- (CYPartyTableView *)creaPartyTableView{
    CYPartyTableView *party = nil;
    
    
    if (self.reuseTableViews.count > 0) {
        party = [self.reuseTableViews lastObject];
        [self.reuseTableViews removeLastObject];
    }else{
        party = [[CYPartyTableView alloc] initWithFrame:CGRectMake(0, kTableViewY + kSegmentH, kScreenFrameW, kScreenFrameH - self.tabBarController.tabBar.height - kTableViewY - kSegmentH) style:UITableViewStylePlain];
        
        
        
        [self.view addSubview:party];
    }
    

    
    
    
    
    return party;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
