//
//  AccountTool.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kFileName @"accounts.data"
#define kFilePath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

#define kCurrentName @"currentAccount.data"
#define kCurrentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentName]
#import "AccountTool.h"
@interface AccountTool()
{
    NSMutableArray *_accounts;
}
@end
@implementation AccountTool
singleton_implementation(AccountTool)

-(id)init{
    if (self =[super init]) {
        //从文件中读取账号信息
        _accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentPath];
        if (_accounts == nil) {
            _accounts = [NSMutableArray array];
        }
        
    }
    return self;
    
}
-(void)addAccount:(Account *)account{
    [_accounts addObject:account];
    _currentAccount = account;
    //归档
    [NSKeyedArchiver archiveRootObject:_accounts toFile:kFilePath];
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
    
}
@end
