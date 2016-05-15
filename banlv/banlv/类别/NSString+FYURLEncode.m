//
//  NSString+FYURLEncode.m
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "NSString+FYURLEncode.h"

@implementation NSString (FYURLEncode)

- (NSString *)encodeURLWithParams:(NSString *)params
{
    
    return [self stringByAppendingString:[params stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
}


@end
