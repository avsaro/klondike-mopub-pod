//
//  AerServCustomEventUtils.h
//  AerservFabricSampleApp
//
//  Created by Hall To on 4/6/17.
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

@end
