//
//  SQGlobalMarco.h
//
//  Created by Shi Eric on 3/18/12.
//  Copyright (c) 2012 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#ifndef _SQGlobalMarco_h
#define _SQGlobalMarco_h

#define kMinOSVersion   4.0f

#define saferelease(foo) {if(foo != nil) {[foo release]; foo = nil;}}

#define isLandscape (UIInterfaceOrientationIsLandscape\
([[UIApplication sharedApplication] statusBarOrientation]))

#define isPad ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define isPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kOSVersion (float)([[[UIDevice currentDevice] systemVersion] length] > 0 ? [[[UIDevice currentDevice] systemVersion] doubleValue] : kMinOSVersion)

#endif
