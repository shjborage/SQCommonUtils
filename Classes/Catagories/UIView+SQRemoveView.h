//
//  UIView+RemoveView.h
//  LotteryClient
//
//  Created by Eric on 8/27/12.
//  Copyright (c) 2012 Inforwave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SQRemoveView)

- (void)sq_removeSubviews:(Class)cls;
- (void)sq_removeAllSubviews;

@end
