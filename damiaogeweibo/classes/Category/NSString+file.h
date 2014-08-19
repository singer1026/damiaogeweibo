//
//  NSString+file.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (file)
- (NSString *)filenameAppend:(NSString *)append;

#pragma mark Unicode编码转成中文
+(NSString *)replaceUnicode:(NSString *)unicodeStr
@end
