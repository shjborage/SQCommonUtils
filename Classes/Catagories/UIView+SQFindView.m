//
//  UIView+SQFindView.m
//  ChildrenEden
//
//  Created by shihaijie on 12/7/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "UIView+SQFindView.h"

@implementation UIView (SQFindView)

- (UIView *)sq_findViewFromSuperView:(Class)cls
{
    if ([self.superview isKindOfClass:cls]) {
        return self.superview;
    } else {
        return [self.superview sq_findViewFromSuperView:cls];
    }
}

@end
