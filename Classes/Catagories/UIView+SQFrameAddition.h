//
//  UIView+Frame.h
//
//  Created by shjborage on 13-5-31.
//  Copyright 2013 Safe&Quick[http://blog.saick.net] All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSQ_ScreenSize   ([[UIScreen mainScreen] bounds].size)
#define kSQ_ScreenWidth   ([[UIScreen mainScreen] bounds].size.width)

@interface UIView (SQFrameAddition)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@end
