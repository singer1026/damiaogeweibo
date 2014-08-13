//
//  Dock.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dock : UIView
-(void) addDockItemWithIcon:(NSString *) icon title:(NSString *)title;

@property(nonatomic,copy) void (^itemClickBlock)(int index);

@property(nonatomic,assign) int selectedIndex;
@end
