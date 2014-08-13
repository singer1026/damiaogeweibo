//
//  DockItem.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-13.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kImageRatio 0.6
#import "DockItem.h"

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        self.adjustsImageWhenHighlighted  = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}
#pragma mark 返回按钮内部titlelabel的边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height*kImageRatio-5, contentRect.size.width, contentRect.size.height-contentRect.size.height*kImageRatio);
}

#pragma mark 返回按钮内部UIImage的边框
-(CGRect) imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*kImageRatio);
}

@end
