//
//  BLScrollView.m
//  banlv
//
//  Created by lfy on 16/5/31.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "BLScrollView.h"

@interface BLScrollView () <UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)NSArray *picArr;

@end

@implementation BLScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picArr = [NSArray arrayWithObjects:@"beijing1",@"beijing2",@"beijing3",@"beijing4", nil];
        
        [self initScrollView];
        [self initPageControl];
        
        
    }
    return self;
}

- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(self.width * 4, self.height);
    
    self.scrollView.pagingEnabled = YES;
    
    for (NSInteger i = 0; i < 4; i++) {
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
        imageView.image = self.picArr[i];
        
        [self.scrollView addSubview:imageView];
        
    }
    
    [self addSubview:self.scrollView];
}

- (void)initPageControl
{
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.width - 150)/2, self.height - 60, 150, 30)];
    self.pageControl.currentPage = 1;
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self addSubview:self.pageControl];

}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x / self.width);
    
    self.pageControl.currentPage = currentPage;
}

@end






