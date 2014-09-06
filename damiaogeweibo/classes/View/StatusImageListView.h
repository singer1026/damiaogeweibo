//
//  StatusImageListView.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusImageListView : UIView
@property(nonatomic,strong) NSArray *imageUrls;
+(CGSize) imageWithCount:(int) count;
@end
