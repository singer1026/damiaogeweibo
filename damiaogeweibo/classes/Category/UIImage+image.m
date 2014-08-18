//
//  UIImage+image.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+(UIImage *) fullscreenImageWithName:(NSString *)name{
    
    if (iPhone5) {
        name = [name filenameAppend:@"-568h@2x"];
    }
    return [UIImage imageNamed:name];
}

+(UIImage *) stretchImageWithName:(NSString *) imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
//    UIEdgeInsets insets = UIEdgeInsetsMake(5, 5, 5, 5);
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}
@end
