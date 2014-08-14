//
//  UIBarButtonItem+create.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (create)
+(UIBarButtonItem *) barButtonItemWithIcon:(NSString *)icon target:(id)target actioin:(SEL)action;
@end
