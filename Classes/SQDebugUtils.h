//
//  SQDebugUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import <UIKit/UIKit.h>

#define __FUNC_NAME__   NSStringFromSelector(_cmd)
#define __CLASS_NAME__  NSStringFromClass([self class])
#define __CALL_STACK__  [NSThread callStackSymbols]
#define __FILE_NAME__   [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

/*
 
 // Detail: http://blog.sina.com.cn/s/blog_8732f19301010pwp.html
 
 __func__
 %s
 Current function signature.
 
 __LINE__
 %d
 Current line number in the source code file.
 
 __FILE__
 %s
 Full path to the source code file.
 
 __PRETTY_FUNCTION__
 %s
 Like __func__, but includes verbose type information in C++ code.

 */


@interface SQTestManager : NSObject

+ (SQTestManager *)defaultManager;

- (void)showMemory;
+ (void)showUseTimes;
+ (void)rewriteAllToFile;

@end
