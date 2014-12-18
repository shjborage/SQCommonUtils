//
//  UINavigationItem+margin.m
//
//  Created by shjborage on 1/20/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "UINavigationItem+SQStyleMargin.h"

@implementation UINavigationItem (SQStyleMargin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

- (void)sq_setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10.0f;
    
    if (_leftBarButtonItem) {
      [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
    } else {
      [self setLeftBarButtonItems:@[negativeSeperator]];
    }
  } else {
    [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
  }
}

- (void)sq_setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10.0f;
    
    if (_rightBarButtonItem) {
      [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
    } else {
      [self setRightBarButtonItems:@[negativeSeperator]];
    }
  } else {
    [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
  }
}

#endif

@end
