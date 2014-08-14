//
//  NewFeatureViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define  kCount 4

#import "NewFeatureViewController.h"
#import "MainViewController.h"
@interface NewFeatureViewController ()
{

    UIPageControl *_pageControl;
    UIButton *_shareBtn;
}
@end

@implementation NewFeatureViewController

-(void)loadView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage fullscreenImageWithName:@"new_feature_background.png"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    self.view = imageView;
    self.view.userInteractionEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize viewSize = self.view.bounds.size;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(kCount*self.view.frame.size.width, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    for (int i = 0; i<kCount; i++) {
        [self addImageViewAtIndex:i scrollView:scrollView];
    }
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    //添加pageController
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.center = CGPointMake(viewSize.width*0.5, viewSize.height*0.95);
    _pageControl.bounds = CGRectMake(0, 0, 100, 20);
    _pageControl.numberOfPages = kCount;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    [self.view addSubview:_pageControl];
    
    
}
-(void) addImageViewAtIndex:(int) index scrollView:(UIScrollView *) scrollView{
    CGSize viewSize = self.view.frame.size;
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d.png",index+1]];
    UIImage *image = [UIImage fullscreenImageWithName:[NSString stringWithFormat:@"new_feature_%d.png",index+1]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(viewSize.width*index, 0,viewSize.width, viewSize.height);
    
    imageView.frame=(CGRect){{viewSize.width*index,0},viewSize};
    [scrollView addSubview:imageView];
    
    //判断是否是最后一张 如果是就添加2个按钮(分享、开始体验)
    if (index==kCount-1) {
        [self addBtnInView:imageView];
    }
}

-(void)addBtnInView:(UIView *)view{
    view.userInteractionEnabled = YES;
    CGSize viewSize = self.view.bounds.size;
    //开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *startBtnNormalImage =[UIImage imageNamed:@"new_feature_finish_button.png"];
//    UIImage *startBtnHighlightedImage =[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"];
//    [startBtn setImage:startBtnNormalImage forState:UIControlStateNormal];
//    [startBtn setImage:startBtnHighlightedImage forState:UIControlStateHighlighted];
    
    CGSize startBtnSize = [startBtn setAllStateBg:@"new_feature_finish_button.png"];
    
    startBtn.center = CGPointMake(viewSize.width*0.5, viewSize.height*0.85);
//    startBtn.bounds=CGRectMake(0, 0, startBtnNormalImage.size.width, startBtnNormalImage.size.height);
    
    startBtn.bounds = (CGRect){CGPointZero , startBtnSize};
    
    [view addSubview:startBtn];
    //监听点击时间 跳转到首页
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //分享按钮
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *shareBtnNormalImage =[UIImage imageNamed:@"new_feature_share_false.png"];
    
    [_shareBtn setImage:shareBtnNormalImage forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
    
    _shareBtn.center = CGPointMake(viewSize.width*0.5, viewSize.height*0.75);
    
    _shareBtn.bounds = (CGRect){CGPointZero , startBtnSize};
    
    [view addSubview:_shareBtn];
    //监听点击时间 跳转到首页
    [_shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    _shareBtn.adjustsImageWhenHighlighted = NO;//不进入点击的高亮状态

    
    _shareBtn.selected = YES;
}


//跳到微博首页
-(void)share:(UIButton *) btn{
    btn.selected = !btn.selected;
}

//跳到微博首页
-(void)start{
    if (_startWeiboBlock) {
        _startWeiboBlock(_shareBtn.selected);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
