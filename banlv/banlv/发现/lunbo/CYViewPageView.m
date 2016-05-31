//
//  CYViewPageView.m
//  LCViewPager
//
//  Created by lcy on 16/5/29.
//  Copyright © 2016年 licong. All rights reserved.
//

#import "CYViewPageView.h"
#import "CYViewPageImgView.h"

#define kScreemWidth [UIScreen mainScreen].bounds.size.width

#define kPagerNumber 5000//图片可以滑动的总页数

#define kTimeInterval 3.0f //设置图片切换时间

@interface CYViewPageView ()<UIScrollViewDelegate,CYViewPagerImgViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CYViewPageImgView *curentImageView;
@property (nonatomic, strong) CYViewPageImgView *nextImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger curentCount;
@end


@implementation CYViewPageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initScrollView];
        [self initPageControl];
        [self initImageViews];
        
        //设置定时器
        [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)setImageAry:(NSArray *)imageAry
{
    _imageAry = imageAry;
    _pageControl.numberOfPages = self.imageAry.count;
    [self setImageViewImage];
}
#pragma mark - 初始化scrollView
- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreemWidth, self.frame.size.height)];
    //设置轮播总页数
    self.scrollView.contentSize = CGSizeMake(kScreemWidth * kPagerNumber, 0);
    //设置轮播图的起始位置在contentView的中间
    //    self.scrollView.contentOffset = CGPointMake(kScreemWidth * kPagerNumber / 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.curentCount = self.scrollView.contentOffset.x / kScreemWidth;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
}
#pragma mark - 初始化pageControl
- (void)initPageControl{
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.center = CGPointMake(kScreemWidth* 0.5, self.frame.size.height *0.9);
    
//    [self addSubview:_pageControl];
}
#pragma mark - 初始化ImageView
- (void)initImageViews
{
    
    self.curentImageView = [[CYViewPageImgView alloc]initWithFrame:CGRectMake(self.curentCount * kScreemWidth, 0, kScreemWidth, self.frame.size.height)];
    self.curentImageView.delegate = self;
    [self.scrollView addSubview:self.curentImageView];
    
    self.nextImageView = [[CYViewPageImgView alloc]initWithFrame:CGRectMake((self.curentCount + 1) * kScreemWidth, 0, kScreemWidth, self.frame.size.height)];
    self.nextImageView.delegate = self;
    [self.scrollView addSubview:self.nextImageView];
    
}

#pragma mark - 定时器方法
- (void)timerChange
{
    CGFloat x = (self.curentCount + 1) * kScreemWidth;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.curentCount = scrollView.contentOffset.x / kScreemWidth;
    [self setImageViewFrame];
    [self setImageViewImage];
    
}

#pragma mark - 改变ImageViewFrame
- (void)setImageViewFrame
{
    CGRect currentFrame = self.curentImageView.frame;
    currentFrame.origin.x = (self.curentCount ) * kScreemWidth;
    self.curentImageView.frame = currentFrame;
    
    CGRect nextFrame = self.curentImageView.frame;
    nextFrame.origin.x = (self.curentCount + 1) * kScreemWidth;
    self.nextImageView.frame = nextFrame;
}

#pragma mark - 改变ImageView图片
- (void)setImageViewImage
{
    if (_imageAry.count > 0) {
        self.curentImageView.imageName = _imageAry[self.curentCount % _imageAry.count];
        self.nextImageView.imageName = _imageAry[(self.curentCount + 1)% _imageAry.count];
        self.pageControl.currentPage = self.curentCount % _imageAry.count;
    }
}

#pragma mark - CYViewPagerImgViewDelegate
- (void)didImageViewClick
{
    NSInteger tag = self.curentCount % _imageAry.count;
    if ([self.delegate respondsToSelector:@selector(didViewPagerViewClick:)]) {
        [self.delegate didViewPagerViewClick:tag];
    }
}

@end

