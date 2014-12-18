//
//  NSDictionary+Ext.h
//
//  Created by heqin on 13-10-16.
//  Copyright (c) 2013年 heqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (SQExt)

- (NSDictionary *)sq_dictionaryForKey:(NSString *)aKey;
- (NSArray *)sq_arrayForKey:(NSString *)aKey;

- (NSString *)sq_stringForKey:(NSString *)aKey;
- (BOOL)sq_boolForKey:(NSString *)aKey;

- (NSNumber *)sq_numberForKey:(NSString *)aKey;
- (float)sq_floatForKey:(NSString *)aKey;
- (double)sq_doubleForKey:(NSString *)aKey;
- (NSInteger)sq_integerForKey:(NSString *)aKey;
- (int)sq_intForKey:(NSString *)aKey;
- (long long)sq_longLongForKey:(NSString *)aKey;
- (long)sq_longForKey:(NSString *)aKey;

@end
