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
@end
