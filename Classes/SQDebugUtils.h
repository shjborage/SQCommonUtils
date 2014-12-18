//
//  SQDebugUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 // For CocoaLumberjack 日志使用方法
 #import "DDLog.h"
 #import "DDTTYLogger.h"
 
 #if DEBUG
 static const int ddLogLevel = LOG_LEVEL_VERBOSE;
 #else
 static const int ddLogLevel = LOG_LEVEL_OFF;
 #define NSLog(...) {}
 #endif
 
 // Add this
 [DDLog addLogger:[DDTTYLogger sharedInstance]];
 */

#define SQDEBUG                 1       // Total switch
#define DISABLE_NSLOG           0       // Disable NSLog(also SQLOG)
#define SQDEBUG_SHOW_MEMORY     1       // Show memory for "- (void)showMemory;"

#if SQDEBUG
#   define SQLOG(...) NSLog(__VA_ARGS__)
#   define SQLOG_RECT(r) NSLog(@"(%.1fx%.1f)-(%.1fx%.1f)", \
            r.origin.x, r.origin.y, r.size.width, r.size.height)
#   define SQTRACE(s) SQLOG(@"SQTRACE --> file:%@ line:%d fun:%@ TraceInfo:%@ <-- SQTRACE", __FILE_NAME__, __LINE__, __FUNC_NAME__, s)
#else
#   define SQLOG(...) {};
#   define SQLOG_RECT(r) {};
#   define SQTRACE(s) {};
#endif

#if DISABLE_NSLOG
#   define NSLog(...) {};
#endif

#ifdef __i386__
//#   define NSLog(...) NSLog(__VA_ARGS__)
#else
//#   define NSLog(...) {}
#endif

//SQLOG(@"file:%@ line:%d fun:%@ ...", __FILE_NAME__, __LINE__, __FUNC_NAME__, ...);

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
