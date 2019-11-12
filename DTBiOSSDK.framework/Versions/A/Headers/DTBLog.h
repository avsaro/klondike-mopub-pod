//
//  DTBLog.h
//  DTBiOSSDK
//
//  Created by Singh, Prashant Bhushan on 2/4/15.
//  Copyright (c) 2015 amazon.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// Log level for the DTBLog util class.
// Lower = finer-grained logs.
typedef enum
{
    DTBLogLevelAll = 0,
    DTBLogLevelTrace = 10,
    DTBLogLevelDebug = 20,
    DTBLogLevelInfo = 30,
    DTBLogLevelWarn	= 40,
    DTBLogLevelError = 50,
    DTBLogLevelFatal = 60,
    DTBLogLevelOff = 70
} DTBLogLevel;


// Util class to log the events in DTB Mobile API.
// Logger works only when the constant DTB_DEBUG_MODE is set to 1 in DTBConstants.h file
// If DTB_DOMAIN is set to BETA then default log level is DTBLogLevelAll
// otherwise default Log level is DTBLogLevelError.
@interface DTBLog : NSObject

// Returns the current set log level
+(DTBLogLevel) logLevel;

// Set's the log level
+(void) setLogLevel:(DTBLogLevel) level;

+(void) trace:(NSString *) format, ...;
+(void) debug:(NSString *) format, ...;
+(void) info:(NSString *) format, ...;
+(void) warn:(NSString *) format, ...;
+(void) error:(NSString *) format, ...;
+(void) fatal:(NSString *) format, ...;

@end
