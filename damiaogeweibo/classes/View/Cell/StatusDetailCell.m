//
//  StatusDetailCell.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-18.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusRetweetOptionBar.h"
#import "MainViewController.h"
#import "StatusDetailViewController.h"

@interface StatusDetailCell()
{
    StatusRetweetOptionBar *_option;
}

@end

@implementation StatusDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addOptionBar];
        _retweet.userInteractionEnabled = YES;
        [_retweet addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetClick)]];

    }
    return self;
}

-(void) retweetClick{
   UINavigationController *nav = [MainViewController sharedMainViewController].selectedViewController;
    StatusDetailViewController *sdvc = [[StatusDetailViewController alloc]init];
    sdvc.status =self.baseFrame.status.retweetedStatus;
    
    [nav pushViewController:sdvc animated:YES];
    
}

-(void) addOptionBar{
    CGFloat retweetWidth = [UIScreen mainScreen].bounds.size.width-2*(kTableBorderWidth+kTableVeiwCellMargin);
    
    
    CGFloat optionHeight =kStatusOptionBarHeight;
    CGFloat optionWidth =200;
    
    CGFloat optionY = _retweet.frame.size.height - optionHeight;
    CGFloat optionX= retweetWidth - optionWidth;
    CGRect frame = CGRectMake(optionX, optionY, optionWidth, optionHeight);
    _option = [[StatusRetweetOptionBar alloc] initWithFrame:frame];
    
    _option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_retweet addSubview:_option];
}
-(void)setBaseFrame:(BaseFrame *)baseFrame{
    [super setBaseFrame:baseFrame];
    _option.status = baseFrame.status.retweetedStatus;
}

@end
