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

@property(nonatomic,strong)NSArray *textArr;

@end

@implementation BLScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picArr = [NSArray arrayWithObjects:@"beijing1",@"beijing2",@"beijing3",@"beijing4", nil];
        
        self.textArr = [NSArray arrayWithObjects:@"guide_bottom_1",@"guide_bottom_2",@"guide_bottom_3",@"guide_bottom_4", nil];
        
        
        [self initScrollView];
        
        [self initPageControl];
        
    }
    return self;
}


- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    self.scrollView.bounces = NO;
    
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(self.width * 4, self.height);
    
    self.scrollView.pagingEnabled = YES;
    
    for (NSInteger i = 0; i < 4; i++) {
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
        
        imageView.image = [UIImage imageNamed:self.picArr[i]];
        
        [self.scrollView addSubview:imageView];
        
        UIImageView *imageText = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width + (self.width - 56) / 2, 30, 56, 376)];
        
        imageText.image = [UIImage imageNamed:self.textArr[i]];
        
        [self.scrollView addSubview:imageText];
        
    }
    
    [self addSubview:self.scrollView];
    
    UIButton *enterApp = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 3 + (self.width - 150) / 2, self.height - 180, 150, 40)];
    
    enterApp.layer.borderColor = [UIColor whiteColor].CGColor;
    
    enterApp.layer.borderWidth = 1.f;
    
    enterApp.layer.cornerRadius = 10.f;
    
    [enterApp setTitle:@"进入伴旅" forState:UIControlStateNormal];
    [enterApp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [enterApp addTarget:self action:@selector(dismissGuideView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:enterApp];
    
}

- (void)dismissGuideView
{
    [self removeFromSuperview];
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






