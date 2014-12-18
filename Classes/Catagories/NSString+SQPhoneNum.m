//
//  NSString+PhoneNum.m
//  BaiduNuomiTuan
//
//  Created by fox on 14-6-25.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "NSString+SQPhoneNum.h"

@implementation NSString (SQPhoneNum)

- (NSString *)sq_secretPhoneNumMode
{
    if (8 <= self.length)
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return self;
}

- (NSString *)sq_showLinePhoneNumMode
{
    return [[self stringByReplacingCharactersInRange:NSMakeRange(4, 0) withString:@"-"] stringByReplacingCharactersInRange:NSMakeRange(8, 0) withString:@"-"];
}

- (BOOL)sq_isValidPhoneNumber
{
    BOOL isValid = YES;
    
    const char* number = [self UTF8String];
    NSInteger len = strlen(number);
    
    for (NSInteger i = 0; i < len; i++) {
        char ch = number[i];
        
        if ((ch < '0'
            || ch > '9')
            && ch != '+'
            && ch != '-')
        {
            isValid = NO;
            break;
        }
    }
    
    return isValid;
}

- (BOOL)sq_isValidPhoneNumber2
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (void)sq_dialNumber
{
    NSString *number = self;
    if ([number sq_isValidPhoneNumber]) {
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", number]];
        if ([[UIApplication sharedApplication] canOpenURL:telURL]) {
#if kBDNAPPMonkeyTestMode
            return;
#endif
            [[UIApplication sharedApplication] openURL:telURL];
        } else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您的设备不支持拨打电话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"该号码\n %@\n不能直接拨打,请使用手机输入后拨打", self] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
