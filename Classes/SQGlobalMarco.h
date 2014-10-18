//
//  SQGlobalMarco.h
//
//  Created by Shi Eric on 3/18/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.saick.net]. All rights reserved.
//

#ifndef _SQGlobalMarco_h
#define _SQGlobalMarco_h

#define ntoa(l) ([NSString stringWithFormat:@"%ld", (long)(l)])

#define kMinOSVersion   4.0f

#define isLandscape (UIInterfaceOrientationIsLandscape\
([[UIApplication sharedApplication] statusBarOrientation]))

#define isPad ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define isPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kSQOSVersion    ([[[UIDevice currentDevice] systemVersion] doubleValue])    // 系统版本
#define kSQScreenSize   [[UIScreen mainScreen] bounds].size

// Radians to degrees
#define kSQRADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
// Degrees to radians
#define kSQDEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#endif
