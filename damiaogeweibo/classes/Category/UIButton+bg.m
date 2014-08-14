//
//  UIButton+bg.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//


@implementation UIButton (bg)
-(CGSize) setAllStateBg:(NSString *)icon{
    
    UIImage *normalImage = [UIImage imageNamed:icon];
    [self setImage:normalImage forState:UIControlStateNormal];
    
    
    [self setImage:[UIImage imageNamed:[icon filenameAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
    return normalImage.size;
    
}
@end
