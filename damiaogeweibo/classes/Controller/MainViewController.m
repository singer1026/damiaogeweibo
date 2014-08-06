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
@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //添加dock
    Dock *dock = [[Dock alloc] init];
    
    dock.frame = CGRectMake(0, self.view.frame.size.height-kDockHeight, self.view.frame.size.width, kDockHeight);
    
    [self.view addSubview:dock];
    
    
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
