//
//  AerServCustomEventUtils.m
//  AerservFabricSampleApp
//
//  Created on 4/6/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventUtils.h"

NSString* const kAppId = @"appId";
NSString* const kPlacement = @"placement";
NSString* const kSiteId = @"siteId";
NSString* const kTimeout = @"timeoutMillis";
NSString* const kUserId = @"userId";
NSString* const kKeywords = @"keywords";

@interface AerServCustomEventUtils ()

@end

@implementation AerServCustomEventUtils

+ (void)initWithAppId:(NSString*)appId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(appId) {
            MPLogInfo(@"Initalizing AerServSDK");
            [AerServSDK initializeWithAppID:appId];
        }
    });
}

#pragma mark - RegEx Util

+ (NSRegularExpression*)createExpressionFromPattern:(NSString*)regExPattern {
    NSError* err = nil;
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:regExPattern
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&err];
    if(err) {
        MPLogInfo(@"AerServCustomEventUtils, createExpressionFromPattern: - ERROR: %@", err.localizedDescription);
        expression = nil;
    }
    return expression;
}

+ (BOOL)string:(NSString*)inputStr containsPattern:(NSString*)regExPattern {
    NSRegularExpression* expression = [AerServCustomEventUtils createExpressionFromPattern:regExPattern];
    NSUInteger matches = 0;
    if(expression && [inputStr isKindOfClass:[NSString class]]) {
        matches = [expression numberOfMatchesInString:inputStr
                                              options:0
                                                range:NSMakeRange(0, inputStr.length)];
    }
    return (matches > 0);
}

+ (NSString*)replaceString:(NSString*)inputStr withPattern:(NSString*)regExPattern andReplacement:(NSString*)replacementStr {
    NSRegularExpression* expression = [AerServCustomEventUtils createExpressionFromPattern:regExPattern];
    NSString* outputStr = inputStr;
    if(expression && [outputStr isKindOfClass:[NSString class]]) {
        outputStr = [expression stringByReplacingMatchesInString:outputStr
                                                         options:0
                                                           range:NSMakeRange(0, outputStr.length)
                                                    withTemplate:replacementStr];
    }
    return outputStr;
}

+ (NSArray*)findMatchesInString:(NSString*)inputStr withPattern:(NSString*)regExPattern {
    NSRegularExpression* expression = [AerServCustomEventUtils createExpressionFromPattern:regExPattern];
    NSArray* matches = nil;
    if([inputStr isKindOfClass:[NSString class]]) {
        matches = [expression matchesInString:inputStr options:0 range:NSMakeRange(0, inputStr.length)];
    }
    return matches;
}

@end
