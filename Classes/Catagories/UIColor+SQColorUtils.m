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
    return [self sq_createImageWithSize:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *)sq_createImageWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *)sq_randomColor
{
    return [UIColor colorWithRed:(CGFloat)255 / (arc4random()%255)
                           green:(CGFloat)255 / (arc4random()%255)
                            blue:(CGFloat)255 / (arc4random()%255)
                           alpha:1.0f];
}

@end
