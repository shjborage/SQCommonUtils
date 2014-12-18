//
//  NSDictionary+Ext.m
//
//  Created by heqin on 13-10-16.
//  Copyright (c) 2013年 heqin. All rights reserved.
//

#import "NSDictionary+SQExt.h"

@implementation NSDictionary (SQExt)

- (NSDictionary *)sq_dictionaryForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSDictionary class]])
            return value;
    }
    
    return nil;
}

- (NSArray *)sq_arrayForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSArray class]])
            return value;
    }
    
    return nil;
}

- (NSString *)sq_stringForKey:(NSString*)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value) {
            if ([value isKindOfClass:[NSString class]])
                return value;
            else if ([value isKindOfClass:[NSNumber class]])
                return [value stringValue];
        }
    }

    return nil;
}

- (NSNumber *)sq_numberForKey:(NSString*)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSNumber class]])
            return value;
    }
    
    return nil;
}

- (float)sq_floatForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value floatValue];
    }
    
    return 0.0f;
}

- (double)sq_doubleForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value doubleValue];
    }
    
    return 0.0;
}

- (NSInteger)sq_integerForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value integerValue];
    }
    
    return 0;
}

- (int)sq_intForKey:(NSString *)aKey
{
    return (int)[self sq_integerForKey:aKey];
}

- (long long)sq_longLongForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value longLongValue];
    }
    
    return 0;
}

- (long)sq_longForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value longValue];
    }
    
    return 0;
}

- (BOOL)sq_boolForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value boolValue];
    }
    
    return NO;
}

@end
