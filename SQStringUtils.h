//
//  StringUtil.h
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (NSStringUtils)

#pragma mark - encode/decode

- (NSString *)encodeAsURIComponent;
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;

+ (NSString *)base64encode:(NSString*)str;
- (NSString *)toUnicode;
+ (NSString *)getUUID;

- (int)charNumber;

#pragma mark - datetime

+ (NSString *)getTimestamp;
+ (NSString *)getCurrentDateTime:(NSString *)strFormat;
- (NSDateComponents *)getDateComponents:(NSString *)strFormat;

#pragma mark - localization

+ (NSString *)localizedString:(NSString *)key;
+ (NSString *)localizedString:(NSString *)key tableName:(NSString *)table;

#pragma mark - other

- (NSString *)useAsFileName;

@end


