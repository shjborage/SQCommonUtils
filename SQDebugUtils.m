//
//  SQDebugUtils.m
//
//  Created by Eric Shi on Jul 18, 2012.
//  Copyright 2012 Safe&Quick[http://www.saick.net]. All rights reserved.
//

#import "SQDebugUtils.h"
#import <mach/mach.h>
#import "SQStringUtils.h"

#define kLastUsedDate       @"test_LastUsedDate"
#define kStartUpTimesPerDay @"test_StartUpTimesPerDay"
#define kAllUsedDate        @"test_AllUsedDate"

static SQTestManager *g_test;

@implementation SQTestManager

+ (SQTestManager *)defaultManager
{
    if (g_test == nil)
        g_test = [[SQTestManager alloc] init];
    
    return g_test;
}

- (vm_size_t)getUsedMemory
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS )
        return info.resident_size;
    else
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    
    return -1;
}

- (void)workTimer:(NSTimer *)timer
{
#if SQDEBUG_SHOW_MEMORY
    SQLOG(@"--------------------Memory Used: %f MB", (float)[self getUsedMemory] / 1024.0f / 1024.0f);
#endif
}

- (void)showMemory
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workTimer:) userInfo:nil repeats:YES];
}

+ (void)showUseTimes
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strLastUsedDate = [userDefaults objectForKey:kLastUsedDate];
    if (strLastUsedDate == nil) {
        [userDefaults setObject:[NSString getCurrentDateTime:@"yyyy-MM-dd"] forKey:kLastUsedDate];
    } else {
        if ([strLastUsedDate isEqualToString:[NSString getCurrentDateTime:@"yyyy-MM-dd"]]) {
            
        } else {
            [userDefaults setInteger:0 forKey:kStartUpTimesPerDay];
        }
    }
    
    NSUInteger uTimes = [userDefaults integerForKey:kStartUpTimesPerDay];
    NSUInteger uAllTimes = [userDefaults integerForKey:kAllUsedDate];
    [userDefaults setInteger:++uTimes forKey:kStartUpTimesPerDay];
    [userDefaults setInteger:++uAllTimes forKey:kAllUsedDate];
    
    [userDefaults setObject:[NSString getCurrentDateTime:@"yyyy-MM-dd"] forKey:kLastUsedDate];
    [userDefaults synchronize];
    
    SQLOG(@"**************************** App : Today used times:%lu, All used times:%lu ***************************", (unsigned long)uTimes, uAllTimes);
}

static void Sys_signal_process(int sig)
{
    fprintf(stderr,"  fatal err sigal = %d\n",sig);
    fflush(stderr);
    
    signal(sig, SIG_DFL);
    raise(sig);
}

static const int sys_fatal_signals[] =
{
    SIGSEGV,
    SIGBUS,
    SIGFPE,
    SIGQUIT,
    0
};

+ (void)rewriteAllToFile
{
    struct sigaction action;
    
    for (int i = 0; sys_fatal_signals[i]; ++i) {
        sigaction(sys_fatal_signals[i], NULL, &action);
        if (action.sa_handler == SIG_DFL) {
            action.sa_handler = Sys_signal_process;
            sigaction(sys_fatal_signals[i], &action, NULL);
        }
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSDate *date = [NSDate date];
    NSString *strDate = [NSString stringWithFormat:@"Log_%@.txt", [date.description substringToIndex:10]];
    NSString *logPath = [documentDir stringByAppendingPathComponent:strDate];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    SQLOG(@"---------------start Date:%@-------------------------------logPath:%@-------------", date.description, logPath);
}

@end


