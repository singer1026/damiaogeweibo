//
//  StatusCell.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusCell.h"
#import "StatusOptionBar.h"
#import "BaseFrame.h"

@interface StatusCell ()
{
    StatusOptionBar *_optionBar;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 3.添加其他
        [self addOtherSubviews];
    }
    return self;
}


#pragma mark 添加其他
- (void)addOtherSubviews
{

    CGFloat y = self.frame.size.height - kStatusOptionBarHeight;
    CGRect frame = CGRectMake(0, y , self.frame.size.width, kStatusOptionBarHeight);
    _optionBar = [[StatusOptionBar alloc] initWithFrame:frame];
    
    
    _optionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_optionBar];
}

- (void)setBaseFrame:(BaseFrame *)baseFrame
{
    [super setBaseFrame:baseFrame];
    
    
    [_optionBar setStatus:self.baseFrame.status];
}


#pragma mark 重写setFrame方法
-(void)setFrame:(CGRect)frame{
    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableTopBorderWitdh;
    frame.size.width -= kTableBorderWidth*2;
    frame.size.height -=kTableVeiwCellMargin;
    [super setFrame:frame];
}

@end
