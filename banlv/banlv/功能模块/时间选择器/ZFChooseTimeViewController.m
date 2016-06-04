//
//  ZFChooseTimeViewController.m
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//



#import "ZFChooseTimeViewController.h"

#import "ZFChooseTimeCollectionViewCell.h"
#import "ZFTimerCollectionReusableView.h"

static NSString * const reuseIdentifier = @"ChooseTimeCell";
static NSString * const headerIdentifier = @"headerIdentifier";



@interface ZFChooseTimeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property(nonatomic,strong) NSArray *currentDate;

@property(nonatomic,assign) NSInteger clickCount;

@end

@implementation ZFChooseTimeViewController

@synthesize date = newDate;
@synthesize collectionView = datecollectionView;

#pragma mark ---
#pragma mark --- 初始化

- (NSArray *)currentDate
{
    if (!_currentDate) {
        
        _currentDate = [NSArray array];
    }
    
    return _currentDate;
}

- (NSTimeZone*)timeZone
{
    
    if (_timeZone == nil) {
        [UIColor blueColor];
        _timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    }
    return _timeZone;
}


- (NSArray*)weekdays
{
    
    if (_weekdays == nil) {
        
        _weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        
    }
    return _weekdays;
}
- (NSCalendar*)calender
{
    
    if (_calender == nil) {
        
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calender;
}
- (NSDateComponents*)comps
{
    
    if (_comps == nil) {
        
        _comps = [[NSDateComponents alloc] init];
        
    }
    
    return _comps;
}
- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}


#pragma mark ---
#pragma mark --- 各种方法
/**
 *  根据当前月获取有多少天
 *
 *  @param dayDate 当前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    
    return range.length;
    
}
/**
 *  根据前几月获取时间
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month

{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:0];
    return mDate;
    
}



/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016年3月”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}

/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString*)getMonthBeginAndEndWith:(NSDate *)dateStr{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return   [self weekdayStringFromDate:beginDate];
}


#pragma mark ---
#pragma mark --- 视图初始化

- (NSMutableArray *)selectedDateArr
{
    if (!_selectedDateArr) {
        
        _selectedDateArr = [NSMutableArray array];
    }
    
    return _selectedDateArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85f];
        
        self.clickCount = 0;
        
        newDate =[NSDate date];
        
        self.currentDate = [self timeString:newDate many:0];
        
        float cellw =(kDeviceWidth - 110)/7;
        
        UIView *DateView = [[UIView alloc] initWithFrame:CGRectMake(40, NavH, kDeviceWidth - 80, kDeviceHeight - 2.5f * NavH)];
        DateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:DateView];
        
        //初始化头部（标题和星期）
        UILabel *inAndOutLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15.f, kDeviceWidth - 80, 40.f)];
        inAndOutLab.text = @"入住时间/离开时间";
        inAndOutLab.textColor = [UIColor colorWithHexString:@"#82CED1"];
        inAndOutLab.textAlignment = NSTextAlignmentCenter;
        [DateView addSubview:inAndOutLab];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(inAndOutLab.frame) + 15.f, self.width - 55 * 2, 1)];
        line1.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [DateView addSubview:line1];
        
        CGFloat weekWidth = (kDeviceWidth - 110) / 7;
        CGFloat leftMargin = 15.f;
        CGFloat yFromLine1 = CGRectGetMaxY(line1.frame);
        
        UILabel *tempLab = nil;
        
        for (NSInteger i = 0; i < 7; i++) {
            
            tempLab = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin + i * weekWidth, yFromLine1 + 5, weekWidth, 30)];
            tempLab.text = self.weekdays[i+1];
            tempLab.textColor = [UIColor colorWithHexString:@"#AEAEAE"];
            tempLab.textAlignment = NSTextAlignmentCenter;
            tempLab.font = [UIFont systemFontOfSize:15.f];
            [DateView addSubview:tempLab];
        }
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(tempLab.frame) + 5.f, self.width - 55 * 2, 1)];
        line2.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [DateView addSubview:line2];
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(cellw, cellw*4/3)];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        [flowLayout setHeaderReferenceSize:CGSizeMake(kDeviceWidth - 110, 10)];
        [flowLayout setMinimumInteritemSpacing:0]; //设置 y 间距
        [flowLayout setMinimumLineSpacing:0]; //设置 x 间距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);//设置其边界
        //UIEdgeInsetsMake(设置上下cell的上间距,设置cell左距离,设置上下cell的下间距,设置cell右距离);
        
        //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
        
        datecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame) + 10, DateView.width, DateView.height - CGRectGetMaxY(line2.frame) - 10) collectionViewLayout:flowLayout];
        datecollectionView.dataSource = self;
        datecollectionView.delegate = self;
        datecollectionView.backgroundColor = [UIColor whiteColor];
        
        //    注册cell
        [datecollectionView registerNib:[UINib nibWithNibName:@"ZFTimerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        
        [datecollectionView registerNib:[UINib nibWithNibName:@"ZFChooseTimeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        [DateView addSubview:datecollectionView];
        
        UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 40) / 2, self.height - 60, 40, 40)];
        [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
        [exitBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
        [self addSubview:exitBtn];
        
    }
    return self;
}

- (void)exitAction
{
    [UIView animateWithDuration:0.2f animations:^{
        
        self.frame = CGRectMake(0, self.height, self.width, 0);
    }];
}

#pragma mark ---
#pragma mark --- <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={kDeviceWidth,50};
    return size;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //显示几个月的数据
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //当前时间 2016-05-21 13:20:57 +0000 （section == 0）
    //下个月同一时间 2016-06-21 13:20:57 +0000 （section == 1）
    //下个月同一时间 2016-07-21 13:20:57 +0000 （section == 2）
    NSDate *dateList = [self getPriousorLaterDateFromDate:newDate withMonth:section];
    
    //当月第一天是周几
    NSString *timerNsstring = [self getMonthBeginAndEndWith:dateList];
    NSInteger p_0 = [timerNsstring integerValue];
    NSInteger p_1 = [self getNumberOfDays:dateList] + p_0;
    
    //当月加上前边的空白cell一共多少天
    return p_1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFChooseTimeCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //获取今天日期（或下月今天日期）
    NSDate*dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
    
    //把日期存为数组(2016,05,21)
    NSArray*array = [self timeString:newDate many:indexPath.section];
    
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    
    NSString *str;

    if (p<10)
    {
        
        str = p > 0 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"-0%ld",(long)-p];

    }
    else
    {
        
        str = [NSString stringWithFormat:@"%ld",(long)p];
    }
    
    //日期数组(2016,05,01)
    NSArray *list = @[array[0], array[1], str];
    
    //currentDate:当前日期(2016,05,21 ：未点击前)(点击后变为点击的日期)
    cell.dateForCell = list;
    
    cell.currentDate = self.currentDate;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.clickCount++;
    
    ZFChooseTimeCollectionViewCell *cell = (ZFChooseTimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.clickCount == 1) {
        
        self.currentDate = cell.dateForCell;
        
        [self.collectionView reloadData];

        
        //让cell的数字背景变绿色直接写在刷新代码下面是不行的，因为刷新需要时间（开辟一个子线程，并延时执行：延时0s也行，好神奇）
        
        //刷新之后，cell指针变量的地址不变，而对应的对象本身地址变了(坑爹啊)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ZFChooseTimeCollectionViewCell *selectedCell = (ZFChooseTimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            
            selectedCell.number.backgroundColor = [UIColor greenColor];
        });
        
        [self.selectedDateArr addObject:cell.dateForCell];
        
    }
    
    if (self.clickCount == 2) {
        
        cell.number.backgroundColor = [UIColor greenColor];
        [self.selectedDateArr addObject:cell.dateForCell];
        
        self.returnDateBlock(self.selectedDateArr);
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.frame = CGRectMake(0, self.height, self.width, 0);
            
            [self.selectedDateArr removeAllObjects];
            self.clickCount = 0;
            
            [self.collectionView reloadData];
        }];
    }
    
    
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ZFTimerCollectionReusableView *headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        [headerCell updateTimer:[self timeString:newDate many:indexPath.section]];
        
        return headerCell;
    }
    return nil;
}




@end
