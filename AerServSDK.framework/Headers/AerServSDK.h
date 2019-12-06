//
//  AerServSDK.h
//  AerServSDK
//
//  Copyright (c) 2014 AerServ, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AerServSDK/ASConstants.h>

#import <AerServSDK/ASAdView.h>
#import <AerServSDK/ASInterstitialViewController.h>
#import <AerServSDK/ASNativeAdView.h>
#import <AerServSDK/ASCustomBannerAdProvider.h>
#import <AerServSDK/ASCustomInterstitialAdProvider.h>

#import <AerServSDK/ASAdView+UnityCheck.h>

@interface AerServSDK : NSObject

/*!
 * Looks into each supplied placement and will run pre-initialization for any mediation partner sources that requires an extra setup phase.
 *
 * @param plcArr, an array of string placement ids (i.e. @[@"1002090", @"1005992"])
 */
+ (void)initializeWithPlacments:(NSArray*)plcArr __deprecated_msg("+initializeWithPlacments: was deprecated. Only the first placement in the array will be used. Please use +initializeWithAppID: instead.");

/*!
 * Looks into the supplied app id and will run pre-initialization for any mediation partner sources that requires an extra setup phase.
 *
 * @param appIdStr, a string of the app id
 */
+ (void)initializeWithAppID:(NSString*)appIdStr;

/*!
 * Returns current AerServSDK version
 */
+ (NSString*)sdkVersion;

/*!
 * Shows console logs for debugging purposes.
 */
+ (void)showLogs:(BOOL)yesOrNo;

/*!
 * Enables testMode. If possible, this will enabled testMode for SDK mediation.
 * Please refer to online integration documentation for list of supported SDK mediations.
 */
+ (void)enableTestMode:(BOOL)yesOrNo;

/*!
 * Returns if the SDK is in testMode mode.
 */
+ (BOOL)isTestModeEnabled;

/*!
 * Returns the GDPR user consent value.
 */
+ (BOOL)getGDPRConsentValue;

/*!
 * Updates GDPR user consent. The updated GDPR user consent value will be used for all subsequent requests.
 * @param userConsent, a boolean flag for GDPR user consent. Set to YES if user consent was given and NO is user consent was denied
 */
+ (void)setGDPRWithUserConsent:(BOOL)userConsent;

@end
