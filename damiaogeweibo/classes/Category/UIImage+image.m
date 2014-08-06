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
        //        // 1.获取没有拓展名的文件名
        //        NSString *filename = [name stringByDeletingPathExtension];
        //
        //        // 2.拼接-568h@2x
        //        filename = [filename stringByAppendingString:@"-568h@2x"];
        //
        //        // 3.拼接拓展名
        //        NSString *extension = [name pathExtension];
        name = [name filenameAppend:@"-568h@2x"];
    }
    return [UIImage imageNamed:name];
    NSLog(@"name--->%@",name);
    return[UIImage imageNamed:name];
}
@end
