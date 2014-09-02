//
//  MBProgressHUD+Show.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-3.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Show)
+ (void)showText:(NSString *)text name:(NSString *)name;
+ (void)showErrorWithText:(NSString *)text;
+ (void)showSuccessWithText:(NSString *)text;
@end
