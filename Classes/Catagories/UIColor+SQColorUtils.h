//
//  ColorUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://blog.saick.net] All rights reserved.
//

#import <UIKit/UIKit.h>

// For Hex, x,y,z maybe 0x00~0xFF
//#define RGB(x, y, z) [UIColor colorWithRed:(x/255.0) green:(y/255.0) blue:(z/255.0) alpha:1.0]
#define kSQ_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (SQColorUtils)

- (UIImage *)sq_createImage;   // add by shjborage@gmail.com May 28, 2012
- (UIImage *)sq_createImageWithSize:(CGSize)size;

+ (UIColor *)sq_randomColor;

@end
