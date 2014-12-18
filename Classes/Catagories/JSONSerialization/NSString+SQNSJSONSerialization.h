//
//  NSString+NSJSONSerialization.h
//  BFServiceStation
//
//  Created by shihaijie on 12/17/13.
//  Copyright (c) 2013 Baofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 模仿JsonKit接口，使用系统Json解析
 默认UTF-8编码
 */

@interface NSString (SQNSJSONSerialization)

- (id)sq_objectFromJSONString;
- (id)sq_objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)parseOptionFlags error:(NSError **)error;

@end
