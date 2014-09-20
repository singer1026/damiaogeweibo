//
//  SlideNavViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-17.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kDefaultScale 0.4

#define kDefaultAlpha 0.7
#import "SlideNavViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SlideNavViewController ()
{
    UIImageView *_imageView;
    UIView *_cover;
    NSMutableArray *_cutImages;
}
@end

@implementation SlideNavViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cutImages = [NSMutableArray array];
    //添加手势监听
    [self.view addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
    
    
    //显示截图的imageView
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame;
    
    //遮罩
    _cover = [[UIView alloc] init];
    _cover.frame = _imageView.frame;
    _cover.backgroundColor = [UIColor darkGrayColor];
    
}

-(void)cut{
    UIView *cutView = self.view.window.rootViewController.view;
    //截图
    
    //开启上下文
//    UIGraphicsBeginImageContext(cutView.frame.size);
    UIGraphicsBeginImageContextWithOptions(cutView.frame.size, YES, 0.0);
    
    //把cutView渲染到上下文中
    [cutView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    [_cutImages addObject:image];
    //取出image
//    _imageView.image =
    
    //结束上下文
    UIGraphicsEndImageContext();
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        [self cut];
    }
    
    [super pushViewController:viewController animated:YES];

}

#pragma mark 监听view的拖拽
-(void)dragView:(UIPanGestureRecognizer *)pan{
    
    //根控制器 直接返回
    if(self.topViewController == self.viewControllers[0]){
        return ;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self beganDrag];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self endedDrag];
            break;
            
        default:
            [self dragging:pan];
            break;
    }
    
}


#pragma mark 开始拖动
- (void)beganDrag
{
    // 添加imageview 和 cover到window中
    [self.view.window insertSubview:_imageView atIndex:0];
    [self.view.window insertSubview:_cover aboveSubview:_imageView];
    
    _imageView.image = _cutImages.lastObject;
}

#pragma mark 结束拖动
- (void)endedDrag
{
    // 取出挪动的距离
    CGFloat tx = self.view.transform.tx;
    // 取出宽度
    CGFloat width = self.view.frame.size.width;
    
    if (tx <= width * 0.5) { // 往左边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 清空transform
            self.view.transform = CGAffineTransformIdentity;
            
            // 让imageView恢复默认的scale
            _imageView.transform = CGAffineTransformMakeScale(kDefaultScale, kDefaultScale);
            
            // 让遮盖恢复默认的alpha
            _cover.alpha = kDefaultAlpha;
        } completion:^(BOOL finished) {
            // 移除两个view
            [_imageView removeFromSuperview];
            [_cover removeFromSuperview];
        }];
    } else { // 往右边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 挪到最右边
            self.view.transform = CGAffineTransformMakeTranslation(width, 0);
            
            // 让imageView缩放为1
            _imageView.transform = CGAffineTransformMakeScale(1, 1);
            
            // 让遮盖alpha变为0
            _cover.alpha = 0;
        } completion:^(BOOL finished) {
            // 清空transform
            self.view.transform = CGAffineTransformIdentity;
            
            // 移除两个view
            [_imageView removeFromSuperview];
            [_cover removeFromSuperview];
            
            // 移除栈顶控制器
            [self popViewControllerAnimated:NO];
            [_cutImages removeLastObject];
        }];
    }
}

// 3/4 让imageview完全显示，遮盖完全消失
#pragma mark 正在拖动
- (void)dragging:(UIPanGestureRecognizer *)pan
{
    // 挪动整个导航view
    CGFloat tx = [pan translationInView:self.view].x;
    if (tx < 0) tx = 0;
    self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    
    // 计算拖动距离的比例
    double txScale = tx/self.view.frame.size.width;
    
    // 让imageview缩放
    double scale = kDefaultScale + (txScale/0.5) * (1 - kDefaultScale);
    if (scale > 1) scale = 1;
    _imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 让遮盖透明度改变
    double alpha = kDefaultAlpha - (txScale/0.5) * kDefaultAlpha;
    _cover.alpha = alpha;
}
@end
