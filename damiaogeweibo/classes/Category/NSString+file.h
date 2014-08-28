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

/**
 * Setup a recorder for a specified file path. After setting it, you can use the other control method to control the shared recorder.
 *
 * @param talkingPath An NSString indicates in which path the recording should be created
 * @returns YES if recorder setup correctly, NO if there is an error
 */
#pragma mark Unicode编码转成中文
+(NSString *)replaceUnicode:(NSString *)unicodeStr
@end
