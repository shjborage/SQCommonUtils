//
//  UIView+SQFrame.m
//
//  Created by Eric Shi on 20140420
//

#import "UIView+SQFrame.h"

@implementation UIView (SQFrame)

- (CGFloat)sq_originX
{
    return self.frame.origin.x;
}

- (CGFloat)sq_originY
{
    return self.frame.origin.y;
}

- (CGPoint)sq_origin
{
    return self.frame.origin;
}

- (CGFloat)sq_width
{
    return self.frame.size.width;
}

- (CGFloat)sq_height
{
    return self.frame.size.height;
}

- (CGSize)sq_size
{
    return self.frame.size;
}

- (void)sq_setOriginX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)sq_setOriginY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)sq_setOrigin:(CGPoint)origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (void)sq_setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)sq_setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)sq_setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (void)sq_setOriginX:(CGFloat)x originY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = width;
    rect.size.height = height;
    self.frame = rect;
}

@end
