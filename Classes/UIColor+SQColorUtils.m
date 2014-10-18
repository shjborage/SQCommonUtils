//
//  ColorUtils.m
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://blog.saick.net]. All rights reserved.
//

#import "UIColor+SQColorUtils.h"

@implementation UIColor (SQColorUtils)

- (UIImage *)sq_createImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
