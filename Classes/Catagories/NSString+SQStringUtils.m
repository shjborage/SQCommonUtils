//
//  StringUtil.m
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://blog.saick.net]. All rights reserved.
//

#import "NSString+SQStringUtils.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

static NSString *_key = @"@WSX$RFV";

static const char* _base64EncodingTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

@implementation NSString (NSStringUtils)

#pragma mark - encode/decode

- (NSString *)sq_encodeAsURIComponent
{
    const char* p = [self UTF8String];
    NSMutableString* result = [NSMutableString string];
    
    for (;*p ;p++) {
        unsigned char c = *p;
        if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_') {
            [result appendFormat:@"%c", c];
        } else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
}

- (NSString *)sq_escapeHTML
{
    NSMutableString* s = [NSMutableString string];
    
    long start = 0;
    long len = [self length];
    NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
    
    while (start < len) {
        NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
        if (r.location == NSNotFound) {
            [s appendString:[self substringFromIndex:start]];
            break;
        }
        
        if (start < r.location) {
            [s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
        }
        
        switch ([self characterAtIndex:r.location]) {
            case '<':
                [s appendString:@"&lt;"];
                break;
            case '>':
                [s appendString:@"&gt;"];
                break;
            case '"':
                [s appendString:@"&quot;"];
                break;
            case '&':
                [s appendString:@"&amp;"];
                break;
        }
        
        start = r.location + 1;
    }
    
    return s;
}

- (NSString *)sq_unescapeHTML
{
    NSMutableString* s = [NSMutableString string];
    NSMutableString* target = [self mutableCopy];
    NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    
    while ([target length] > 0) {
        NSRange r = [target rangeOfCharacterFromSet:chs];
        if (r.location == NSNotFound) {
            [s appendString:target];
            break;
        }
        
        if (r.location > 0) {
            [s appendString:[target substringToIndex:r.location]];
            [target deleteCharactersInRange:NSMakeRange(0, r.location)];
        }
        
        if ([target hasPrefix:@"&lt;"]) {
            [s appendString:@"<"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&gt;"]) {
            [s appendString:@">"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&quot;"]) {
            [s appendString:@"\""];
            [target deleteCharactersInRange:NSMakeRange(0, 6)];
        } else if ([target hasPrefix:@"&amp;"]) {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 5)];
        } else {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    
    return s;
}

- (NSString *)sq_urlEncodedString
{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)sq_urlDecodedString
{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

- (NSString *)sq_toUnicode
{
    //    NSStringEncoding enc_gb2312 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //    char* temp = (char*)[[NSString stringWithString:target] cStringUsingEncoding:NSUnicodeStringEncoding];
    //    return [NSString stringWithCString:temp encoding:NSUnicodeStringEncoding];
    NSMutableString* target = [self mutableCopy];
    NSData *tmp_data = [target dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSString *tmp_ret = [[NSString alloc] initWithData:tmp_data encoding:NSUnicodeStringEncoding] ;
    return tmp_ret;
}

+ (NSString *)sq_getUUID
{
    CFUUIDRef     UUID;
    CFStringRef   UUIDString;
    char          buffer[100];
    memset(buffer, 0, 100);
    
    UUID = CFUUIDCreate(kCFAllocatorDefault);
    UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
    
    // This is the safest way to obtain a C string from a CFString.
    CFStringGetCString(UUIDString, buffer, 100, kCFStringEncodingASCII);
    CFRelease(UUIDString);
    CFRelease(UUID);
    return [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
}

#pragma mark - datetime

+ (NSString *)sq_getDateTime:(NSString *)strFormat fromDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if ([strFormat length] > 0)
        [df setDateFormat:strFormat];
    else
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df stringFromDate:date];
}

+ (NSString *)sq_getCurrentDateTime:(NSString *)strFormat
{
    /*    // string to date
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
     [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate* date_new = [df dateFromString:@"2012-01-24 00:11:11"];
     
     // date to dateComponets
     NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     NSDate* today = [NSDate date];
     NSUInteger uFlag = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
     NSDateComponents *dcToday = [gregorian components:uFlag fromDate:today];
     
     // other usage
     NSDate *date_now = [NSDate date];
     NSString *strDate = [date_now descriptionWithLocale:[NSLocale currentLocale]];
     return [strDate substringToIndex:[strDate rangeOfString:@"China Standard Time"].location - 1];
     */
    NSDate *date_now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([strFormat length] > 0)
        [df setDateFormat:strFormat];
    else
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df stringFromDate:date_now];
}

+ (NSString *)sq_getTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSInteger location = [timeString rangeOfString:@"."].location;
    timeString=[timeString substringToIndex:location];
    
    return timeString;
}

- (NSDateComponents *)sq_getDateComponents:(NSString *)strFormat
{
    // string to date
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    if ([strFormat length] > 0)
        [df setDateFormat:strFormat];//@"yyyy-MM-dd HH:mm:ss"];
    else
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date_new = [df dateFromString:self];
    
    // date to dateComponets
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger uFlag = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *dcNew = [gregorian components:uFlag fromDate:date_new];
    
    return dcNew;
}

- (NSDate *)sq_getDate:(NSString *)strFormat
{
    // string to date
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    if ([strFormat length] > 0)
        [df setDateFormat:strFormat];//@"yyyy-MM-dd HH:mm:ss"];
    else
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df dateFromString:self];
}

#pragma mark - localization

+ (NSString *)sq_localized:(NSString*)key
{
    return NSLocalizedString(key, nil);
}

+ (NSString *)sq_localized:(NSString *)key tableName:(NSString *)table
{
    return NSLocalizedStringFromTable(key, table, nil);
}

#pragma mark - other

- (NSString *)sq_useAsFileName             // add by shjborage Apr 18, 2012
{
    NSString *strTmp = self;
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"/" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"\\" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@":" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"*" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"?" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"\"" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"<" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@">" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"|" withString:@" "];
    return strTmp;
}

/*!
 默认的length返回 unicode长度，这个中文汉字长度为2，英文数字为1
 */
- (int)sq_charNumber
{
    int nLength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            nLength++;
        } else {
            p++;
        }
    }
    return nLength;
}


#pragma mark - crypt/decrypt

+ (NSString *)sq_md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
}

+ (NSString *)sq_encryptStr:(NSString *) str
{
    return [NSString sq_doCipher:str key:_key context:kCCEncrypt];
}

+ (NSString *)sq_decryptStr:(NSString *) str
{
    return [NSString sq_doCipher:str key:_key context:kCCDecrypt];
}

+ (NSString *)sq_doCipher:(NSString *)sTextIn key:(NSString *)sKey
                  context:(CCOperation)encryptOrDecrypt
{
    NSStringEncoding EnC = NSUTF8StringEncoding;
    
    NSMutableData * dTextIn;
    if (encryptOrDecrypt == kCCDecrypt) {
        dTextIn = [[NSString sq_decodeBase64WithString:sTextIn] mutableCopy];
    } else{
        dTextIn = [[sTextIn dataUsingEncoding: EnC] mutableCopy];
    }
    NSMutableData * dKey = [[sKey dataUsingEncoding:EnC] mutableCopy];
    [dKey setLength:kCCBlockSizeDES];
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
    //memset((void *) iv, 0x0, (size_t) sizeof(iv));
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    bufferPtrSize1 = ([sTextIn length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    bufferPtr1 = (uint8_t*)malloc(bufferPtrSize1 * sizeof(uint8_t));
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);
    CCCrypt(encryptOrDecrypt, // CCOperation op
            kCCAlgorithmDES, // CCAlgorithm alg
            kCCOptionPKCS7Padding, // CCOptions options
            [dKey bytes], // const void *key
            [dKey length], // size_t keyLength
            iv, // const void *iv
            [dTextIn bytes], // const void *dataIn
            [dTextIn length],  // size_t dataInLength
            (void *)bufferPtr1, // void *dataOut
            bufferPtrSize1,     // size_t dataOutAvailable
            &movedBytes1);      // size_t *dataOutMoved
    
    
    NSString * sResult;
    if (encryptOrDecrypt == kCCDecrypt){
        sResult = [[ NSString alloc] initWithData:[NSData dataWithBytes:bufferPtr1
                                                                 length:movedBytes1] encoding:EnC];
    } else {
        NSData *dResult = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        sResult = [NSString sq_encodeBase64WithData:dResult];
    }
    return sResult;
}

#pragma mark - base64

+ (NSString *)sq_encodeBase64WithString:(NSString *)strData
{
    return [NSString sq_encodeBase64WithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)sq_encodeBase64WithData:(NSData *)objData
{
    const unsigned char * objRawData = (const unsigned char*)[objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    unsigned long intLength = [objData length];
    if (intLength == 0)
        return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3;
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        } else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
}

+ (NSData *)sq_decodeBase64WithString:(NSString *)strBase64
{
    const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned long intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char * objResult;
    objResult = (unsigned char*)calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
    free(objResult);
    return objData;
}

#pragma mark - 汉化

+ (NSString *)weekToChinese:(NSString *)enWeek
{
    if (!([enWeek length] > 0)) {
        return nil;
    }

    NSString *chWeek = [NSString stringWithString:enWeek];
    
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Mon" withString:@"周一"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Tue" withString:@"周二"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Wed" withString:@"周三"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Thu" withString:@"周四"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Fri" withString:@"周五"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Sat" withString:@"周六"];
    chWeek = [chWeek stringByReplacingOccurrencesOfString:@"Sun" withString:@"周日"];
    
    return chWeek;
}

// 中文转英文
+ (NSString *)chineseToEnglish:(NSString *)cnWeek
{
    if (!([cnWeek length] > 0)) {
        return nil;
    }
    
    NSString *enWeek = [NSString stringWithString:cnWeek];
    
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周一" withString:@"Mon"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周二" withString:@"Tue"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周三" withString:@"Wed"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周四" withString:@"Thu"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周五" withString:@"Fri"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周六" withString:@"Sat"];
    enWeek = [enWeek stringByReplacingOccurrencesOfString:@"周日" withString:@"Sun"];
    
    return enWeek;
}

+ (NSString *)numToChinese:(NSString *)enNum
{
    if (!([enNum length] > 0)) {
        return nil;
    }
    
    switch ([enNum integerValue]) {
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        case 7:
            return @"七";
            break;
        case 8:
            return @"八";
            break;
        case 9:
            return @"九";
            break;
        case 10:
            return @"十";
            break;
            
        default:
            return @"";
            break;
    }
}

@end
