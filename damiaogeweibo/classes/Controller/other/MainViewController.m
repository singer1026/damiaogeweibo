//
//  MainViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define  kDockHeight 44
#import "MainViewController.h"
#import "Dock.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
@interface MainViewController ()
{
    UIViewController *_selectedViewController;
}

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
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
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    [super addChildViewController:nav];
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
    Dock *dock = [[Dock alloc] init];
    
    dock.frame = CGRectMake(0, self.view.frame.size.height-kDockHeight, self.view.frame.size.width, kDockHeight);
    
    [self.view addSubview:dock];
    
    
    //添加dockItem
    [dock addDockItemWithIcon:@"tabbar_home.png" title:@"首页"];
    [dock addDockItemWithIcon:@"tabbar_message_center.png" title:@"消息"];
    [dock addDockItemWithIcon:@"tabbar_profile.png" title:@"我"];
    [dock addDockItemWithIcon:@"tabbar_discover.png" title:@"广场"];
    [dock addDockItemWithIcon:@"tabbar_more.png" title:@"更多"];
    
    //监听dockItem的点击
    dock.itemClickBlock = ^(int index){
        [self selectControllerAtIndex:index];
    };
}

-(void)selectControllerAtIndex:(int) index{
    //tabbar切换控制器
    UIViewController *vc = self.childViewControllers[index];
    if (_selectedViewController  == vc) {
        return ;
    }
    
    if (_selectedViewController) {
        [_selectedViewController.view removeFromSuperview];
    }
    
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kDockHeight);
    [self.view addSubview:vc.view];
    _selectedViewController = vc;
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
