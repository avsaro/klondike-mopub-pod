//
//  InMobiSDKInitialiser.h
//  InMobiMoPubSampleApp
//
//

#import <Foundation/Foundation.h>

@interface InMobiSDKInitialiser : NSObject

/**
 * Initialises the InMobi SDK with InMobi's Account ID
 */
+ (void)initialiseSDK:(NSString *)accountId withError:(NSError **)error;

/**
 * Checks if the InMobi SDK is already initialised or not
 */
+ (BOOL)isSDKInitialised;

/**
 * @discussion Update the consent Dictionary in the SDK
 */
+ (void)updateGDPRConsent;

@end
