//
//  UIBarButtonItem+create.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//



@implementation UIBarButtonItem (create)
+(UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target actioin:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSString *imageName = icon;
    
    CGSize imageSize = [btn setAllStateBg:imageName];
    
    
    btn.bounds = (CGRect){CGPointZero,imageSize};
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
