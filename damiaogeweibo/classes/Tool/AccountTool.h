//
//  AccountTool.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"

@interface AccountTool : NSObject
singleton_interface(AccountTool)
@property (strong, nonatomic,readonly) Account *currentAccount;

-(void) addAccount:(Account *)account;

@end
