//
//  StatusDetailTitileView.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-20.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusDetailTitileView.h"

@implementation StatusDetailTitileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bg = [[UIImageView alloc]init];
        
        bg.image =[UIImage stretchImageWithName:@"statusdetail_comment_top_background.png"];
        
        
        [self addBtns];
        
        
        //小三角指示器
        UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow.png"]];
        
        
    }
    return self;
}

-(void)addBtns{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.text = @"转发";
}


@end
