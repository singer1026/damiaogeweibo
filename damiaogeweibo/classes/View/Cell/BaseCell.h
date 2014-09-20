//
//  BaseCell.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-18.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFrame.h"

@interface BaseCell : UITableViewCell
{
    UIImageView *_retweet;
    BaseFrame *_baseFrame;
    
}
@property (nonatomic, strong) BaseFrame *baseFrame;
@end
