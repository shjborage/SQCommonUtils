//
//  SQGlobalMarco.h
//
//  Created by Shi Eric on 3/18/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.saick.net]. All rights reserved.
//

#ifndef _SQGlobalMarco_h
#define _SQGlobalMarco_h

#define kSQ_OSVersion ((float)[[[UIDevice currentDevice] systemVersion] doubleValue])

#define kSQ_isLandscape (UIInterfaceOrientationIsLandscape\
([[UIApplication sharedApplication] statusBarOrientation]))

#define kSQ_isPad ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kSQ_is4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSQ_is3_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// Radians to degrees
#define kSQ_RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
// Degrees to radians
#define kSQ_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define kSQ_WEAK_REF(obj) \
__weak typeof(obj) weak_##obj = obj; \

#define kSQ_STRONG_REF(obj) \
__strong typeof(weak_##obj) obj = weak_##obj; \

#endif
