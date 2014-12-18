//
//  UINavigationItem+margin.h
//
//  Created by shjborage on 1/20/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (SQStyleMargin)

- (void)sq_setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem;
- (void)sq_setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem;

@end
