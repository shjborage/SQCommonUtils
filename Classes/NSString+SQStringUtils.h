//
//  StringUtil.h
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SQNSStringUtils)

#pragma mark - encode/decode

- (NSString *)sq_encodeAsURIComponent;
- (NSString *)sq_escapeHTML;
- (NSString *)sq_unescapeHTML;

+ (NSString *)sq_base64encode:(NSString*)str;
- (NSString *)sq_toUnicode;
+ (NSString *)sq_getUUID;

- (int)sq_charNumber;

#pragma mark - datetime

+ (NSString *)sq_getTimestamp;
+ (NSString *)sq_getCurrentDateTime:(NSString *)strFormat;
- (NSDateComponents *)sq_getDateComponents:(NSString *)strFormat;

#pragma mark - localization

+ (NSString *)sq_localizedString:(NSString *)key;
+ (NSString *)sq_localizedString:(NSString *)key tableName:(NSString *)table;

#pragma mark - other

- (NSString *)sq_useAsFileName;

@end


