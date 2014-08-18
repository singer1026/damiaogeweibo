//
//  UIButton+bg.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//


@implementation UIButton (bg)
-(CGSize) setAllStateBg:(NSString *)icon{
    
    UIImage *normalImage = [UIImage stretchImageWithName:icon];
    [self setImage:normalImage forState:UIControlStateNormal];
    UIImage *highlightedImage = [UIImage stretchImageWithName:[icon filenameAppend:@"_highlighted"]];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
    return normalImage.size;
    
}
@end
