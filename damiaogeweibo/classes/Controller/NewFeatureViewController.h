//
//  NewFeatureViewController.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureViewController : UIViewController <UIScrollViewDelegate>
@property(nonatomic,copy) void (^startWeiboBlock)(BOOL shared);
@end
