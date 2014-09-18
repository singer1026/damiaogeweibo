//
//  StatusDetailViewController.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-17.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

@interface StatusDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) Status *status;
@end
