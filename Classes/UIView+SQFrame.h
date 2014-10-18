//
//  UIView+SQFrame.h
//
//  Created by Eric Shi 20140420
//

#import <UIKit/UIKit.h>

@interface UIView (SQFrame)

- (CGFloat)sq_originX;
- (CGFloat)sq_originY;
- (CGPoint)sq_origin;
- (CGFloat)sq_width;
- (CGFloat)sq_height;
- (CGSize)sq_size;

- (void)sq_setOriginX:(CGFloat)x;
- (void)sq_setOriginY:(CGFloat)y;
- (void)sq_setOrigin:(CGPoint)origin;
- (void)sq_setWidth:(CGFloat)width;
- (void)sq_setHeight:(CGFloat)height;
- (void)sq_setSize:(CGSize)size;

- (void)sq_setOriginX:(CGFloat)x originY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@end
