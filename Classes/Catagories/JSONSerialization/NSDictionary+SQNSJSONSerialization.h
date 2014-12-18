//
//  NSDictionary+NSJSONSerialization.h
//  BFServiceStation
//
//  Created by shihaijie on 12/17/13.
//  Copyright (c) 2013 Baofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SQNSJSONSerialization)

- (NSString *)sq_JSONString;
- (NSString *)sq_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;

@end
