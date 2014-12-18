//
//  NSString+NSJSONSerialization.m
//  BFServiceStation
//
//  Created by shihaijie on 12/17/13.
//  Copyright (c) 2013 Baofeng. All rights reserved.
//

#import "NSString+SQNSJSONSerialization.h"

@implementation NSString (SQNSJSONSerialization)

- (id)sq_objectFromJSONString
{
    return [self sq_objectFromJSONStringWithParseOptions:NSJSONReadingMutableLeaves error:nil];
}

- (id)sq_objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)parseOptionFlags error:(NSError **)error
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:parseOptionFlags error:error];
}

@end
