//
//  StatusDetailTitileView.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-20.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
typedef enum {
    TitleViewBtnTypeComment,
    TitleViewBtnTypeRepost,
    TitleViewBtnTypeAttitude
}TitleViewBtnType;

#import <UIKit/UIKit.h>
#import "Status.h"
@interface StatusDetailTitileView : UIView
@property (strong, nonatomic)  Status* status;
@property(nonatomic,assign) TitleViewBtnType type;
@property(nonatomic,copy) void (^btnClickBlock)(TitleViewBtnType type);
@end
