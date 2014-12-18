//
//  NSArray+NSJSONSerialization.m
//  BFServiceStation
//
//  Created by shihaijie on 12/17/13.
//  Copyright (c) 2013 Baofeng. All rights reserved.
//

#import "NSArray+SQNSJSONSerialization.h"

@implementation NSArray (SQNSJSONSerialization)

- (NSString *)sq_JSONString
{
    return [self sq_JSONStringWithOptions:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)sq_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:serializeOptions error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
