//
//  NSString+PhoneNum.h
//  BaiduNuomiTuan
//
//  Created by fox on 14-6-25.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

@import UIKit;

@interface NSString (SQPhoneNum)

- (NSString *)sq_secretPhoneNumMode;
- (NSString *)sq_showLinePhoneNumMode;
- (BOOL)sq_isValidPhoneNumber;
- (BOOL)sq_isValidPhoneNumber2;
- (void)sq_dialNumber;

@end
