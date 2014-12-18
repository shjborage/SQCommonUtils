//
//  UIView+RemoveView.m
//  LotteryClient
//
//  Created by Eric on 8/27/12.
//  Copyright (c) 2012 Inforwave. All rights reserved.
//

#import "UIView+SQRemoveView.h"

@implementation UIView (SQRemoveView)

- (void)sq_removeSubviews:(Class)class
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class])
            [view removeFromSuperview];
    }
}

- (void)sq_removeAllSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
