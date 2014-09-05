//
//  IconView.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-5.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
@class User;

typedef enum {
    IconViewTypeDefault = 0,
    IconViewTypeSmall,
    IconViewTypeBig
} IconViewType;


#import <UIKit/UIKit.h>
@interface IconView : UIView
@property (strong, nonatomic) User *user;
@property (nonatomic,assign) IconViewType iconViewType;

+(CGSize) iconViewSizeWithType:(IconViewType)type;
@end
