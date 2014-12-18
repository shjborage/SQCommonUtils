//
//  StringUtil.h
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSQ_ntoa(l) ([NSString stringWithFormat:@"%ld", (long)(l)])
#define kSQ_safeString(s) ([s length] > 0 ? s : @"")

@interface NSString (NSStringUtils)

#pragma mark - encode/decode

- (NSString *)sq_encodeAsURIComponent;
- (NSString *)sq_escapeHTML;
- (NSString *)sq_unescapeHTML;

- (NSString *)sq_urlEncodedString;
- (NSString *)sq_urlDecodedString;

- (NSString *)sq_toUnicode;
+ (NSString *)sq_getUUID;

#pragma mark - datetime

+ (NSString *)sq_getTimestamp;
+ (NSString *)sq_getDateTime:(NSString *)strFormat fromDate:(NSDate *)date;
+ (NSString *)sq_getCurrentDateTime:(NSString *)strFormat;
- (NSDateComponents *)sq_getDateComponents:(NSString *)strFormat;
- (NSDate *)sq_getDate:(NSString *)strFormat;

#pragma mark - localization

+ (NSString *)sq_localized:(NSString *)key;
+ (NSString *)sq_localized:(NSString *)key tableName:(NSString *)table;

#pragma mark - 汉化

+ (NSString *)weekToChinese:(NSString *)enWeek;
+ (NSString *)chineseToEnglish:(NSString *)cnWeek;
// 简单转换，现只支持10以内的数
+ (NSString *)numToChinese:(NSString *)enNum;

#pragma mark - other

- (int)sq_charNumber;
- (NSString *)sq_useAsFileName;

#pragma mark - crypt/decrypt

+ (NSString *)sq_md5:(NSString *)str;
+ (NSString *)sq_encryptStr:(NSString *)str;
+ (NSString *)sq_decryptStr:(NSString *)str;

#pragma mark Based64

+ (NSString *)sq_encodeBase64WithString:(NSString *)strData;
+ (NSString *)sq_encodeBase64WithData:(NSData *)objData;
+ (NSData *)sq_decodeBase64WithString:(NSString *)strBase64;

@end


