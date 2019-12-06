//
//  AerServCustomEventUtils.h
//  AerservFabricSampleApp
//
//  Created on 4/6/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import "MPLogging.h"

extern NSString* const kAppId;
extern NSString* const kKeywords;
extern NSString* const kPlacement;
extern NSString* const kSiteId;
extern NSString* const kTimeout;
extern NSString* const kUserId;

@interface AerServCustomEventUtils : NSObject

+ (void)initWithAppId:(NSString*)appId;

#pragma mark - RegEx Util

+ (BOOL)string:(NSString*)inputStr containsPattern:(NSString*)regExPattern;
+ (NSString*)replaceString:(NSString*)inputStr withPattern:(NSString*)regExPattern andReplacement:(NSString*)replacementStr;
+ (NSArray*)findMatchesInString:(NSString*)inputStr withPattern:(NSString*)regExPattern;

@end
