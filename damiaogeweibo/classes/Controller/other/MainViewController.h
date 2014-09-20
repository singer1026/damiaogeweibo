//
//  MainViewController.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface MainViewController : UIViewController<UINavigationControllerDelegate>

singleton_interface(MainViewController)

@property(nonatomic,readonly,strong) UINavigationController* selectedViewController;
@end
