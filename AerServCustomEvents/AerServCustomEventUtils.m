//
//  AerServCustomEventUtils.m
//  AerservFabricSampleApp
//
//  Created by Hall To on 4/6/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import "AerServSDK/AerServSDK.h"
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

@end
