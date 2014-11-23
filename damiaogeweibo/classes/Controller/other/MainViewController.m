//
//  MainViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define  kDockHeight 44
#define  kContentFrame  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kDockHeight)

#define  kDockFrame CGRectMake(0, self.view.frame.size.height-kDockHeight, self.view.frame.size.width, kDockHeight)

#import "MainViewController.h"
#import "Dock.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "SlideNavViewController.h"

@interface MainViewController ()
{
    
    Dock *_dock;
}

@end

@implementation MainViewController
singleton_implementation(MainViewController)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    [self addDock];
    
    //创建所有的子控制器
    [self createChildViewControllers];
    
    [self selectControllerAtIndex:0];
    
    //设置导航栏样式
    [self setNavigationTheme];

}

#pragma mark 设置导航栏样式
-(void) setNavigationTheme{
    //操作整个应用中的所有导航栏，只需要给它设置就可以了
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if(!IOS7){
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //设置状态栏背景样式
    [UIApplication sharedApplication].statusBarStyle =
    UIStatusBarStyleLightContent;
    
    [navBar setTitleTextAttributes:
     @{
       UITextAttributeTextColor : [UIColor darkGrayColor],
       UITextAttributeTextShadowOffset :
           [NSValue valueWithUIOffset:UIOffsetZero]
       }];
    
    
    //统一设置导航栏的按钮背景
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:
     [UIImage imageNamed:@"navigationbar_button_background_disabled.png"]
                       forState:UIControlStateDisabled
                     barMetrics:UIBarMetricsDefault];
    
    NSDictionary *textAttrbutes=@{
                                  UITextAttributeFont:[UIFont systemFontOfSize:12],
                                  UITextAttributeTextColor : [UIColor darkGrayColor],
                                  UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                  };
    
    [barItem setTitleTextAttributes:textAttrbutes forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:textAttrbutes forState:UIControlStateHighlighted];
}

#pragma mark 重写addChildViewController方法
-(void)addChildViewController:(UIViewController *)childController{
    SlideNavViewController *nav = [[SlideNavViewController alloc] initWithRootViewController:childController];
    nav.delegate = self;
    
    [super addChildViewController:nav];
}

#pragma mark -导航控制器的代理方法
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
 
     UIViewController *root = navigationController.viewControllers[0];
    if (viewController != root) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self actioin:@selector(back)];
        
         viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_more.png" target:self actioin:@selector(home)];
        [viewController.view setBackgroundColor:kGlobalBg];
        //更改导航控制器的高度
        navigationController.view.frame = self.view.bounds;
        
        
        //从mainViewController移除
        [_dock removeFromSuperview];
        
        // 调整Dock的Y值
        CGRect dockFrame = _dock.frame;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kDockHeight;
        } else {
            dockFrame.origin.y -= kDockHeight;
        }
        _dock.frame = dockFrame;
        
        //添加dock到根控制器界面
        [root.view addSubview:_dock];

    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        // 更改导航控制器view的frame
        navigationController.view.frame = kContentFrame;
        
        // 让Dock从root上移除
        [_dock removeFromSuperview];
        
        // 添加dock到MainViewController
        _dock.frame = kDockFrame;
        [self.view addSubview:_dock];
    }
}

-(void)home{
    [_selectedViewController popToRootViewControllerAnimated:YES];
}

-(void)back{
    [_selectedViewController popViewControllerAnimated:YES];
}

-(void)createChildViewControllers{
    HomeViewController *home = [[HomeViewController alloc] init];
   
    MessageViewController *message = [[MessageViewController alloc] init];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
   
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];

    MoreViewController *more = [[MoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [more.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self addChildViewController:home];
    [self addChildViewController:message];
    [self addChildViewController:profile];
    [self addChildViewController:discover];
    [self addChildViewController:more];
    
    
}

#pragma mark- 添加Dock
-(void)addDock{
    //添加dock
    _dock = [[Dock alloc] init];
    
    _dock.frame = kDockFrame;
    
    [self.view addSubview:_dock];
    
    
    //添加dockItem
    [_dock addDockItemWithIcon:@"tabbar_home.png" title:@"首页"];
    [_dock addDockItemWithIcon:@"tabbar_message_center.png" title:@"消息"];
    [_dock addDockItemWithIcon:@"tabbar_profile.png" title:@"我"];
    [_dock addDockItemWithIcon:@"tabbar_discover.png" title:@"广场"];
    [_dock addDockItemWithIcon:@"tabbar_more.png" title:@"更多"];
    
    //监听dockItem的点击
    _dock.itemClickBlock = ^(int index){
        [[MainViewController sharedMainViewController] selectControllerAtIndex:index];
    };
}

-(void)selectControllerAtIndex:(int) index{
    //tabbar切换控制器
    UINavigationController *vc = self.childViewControllers[index];
    if (_selectedViewController  == vc) {
        return ;
    }
    
    if (_selectedViewController) {
        [_selectedViewController.view removeFromSuperview];
    }
    
    vc.view.frame = kContentFrame;
    [self.view addSubview:vc.view];
    _selectedViewController = vc;
}

@end
