//
//  InMobiInterstitialCustomEvent.m
//  InMobi
//

#import "InMobiInterstitialCustomEvent.h"
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPLogging.h"
#endif
#import <InMobiSDK/IMSdk.h>
#import "InMobiGDPR.h"
#import "MPConstants.h"

@interface InMobiInterstitialCustomEvent ()

@property (nonatomic, retain) IMInterstitial *inMobiInterstitial;

@end

@implementation InMobiInterstitialCustomEvent

@synthesize inMobiInterstitial = _inMobiInterstitial;

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting InMobi interstitial");

    NSMutableDictionary *gdprConsentObject = [[NSMutableDictionary alloc] init];
    NSString* consent = @"false";
    if([InMobiGDPR getConsent]){
        consent = @"true";
    }
    [gdprConsentObject setObject:consent forKey:IM_GDPR_CONSENT_AVAILABLE];
    [gdprConsentObject setValue:[InMobiGDPR isGDPR] forKey:@"gdpr"];
    //InMobi SDK initialization with the account id setup @Mopub dashboard
    [IMSdk initWithAccountID:[info valueForKey:@"accountid"] consentDictionary:gdprConsentObject];
    long long placementId = [[info valueForKey:@"placementid"] longLongValue];
    IMInterstitial *inMobiInterstitial = [[IMInterstitial alloc] initWithPlacementId:placementId];
    inMobiInterstitial.delegate = self;
    self.inMobiInterstitial = inMobiInterstitial;
    /*
     Mandatory params to be set by the publisher to identify the supply source type
     */
    
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
    [paramsDict setObject:@"c_mopub" forKey:@"tp"];
	[paramsDict setObject:MP_SDK_VERSION forKey:@"tp-ver"];
    
    /*
     Sample for setting up the InMobi SDK Demographic params.
     Publisher need to set the values of params as they want.
     
     [IMSdk setAreaCode:@"1223"];
     [IMSdk setEducation:kIMSDKEducationHighSchoolOrLess];
     [IMSdk setGender:kIMSDKGenderMale];
     [IMSdk setAge:12];
     [IMSdk setPostalCode:@"234"];
     [IMSdk setLogLevel:kIMSDKLogLevelDebug];
     [IMSdk setLocationWithCity:@"BAN" state:@"KAN" country:@"IND"];
     [IMSdk setLanguage:@"ENG"];
     */

    self.inMobiInterstitial.extras = paramsDict; // For supply source identification
    [self.inMobiInterstitial load];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    [self.inMobiInterstitial showFromViewController:rootViewController withAnimation:kIMInterstitialAnimationTypeCoverVertical];
}

#pragma mark - IMInterstitialDelegate


-(void)interstitialDidFinishLoading:(IMInterstitial*)interstitial {
    MPLogInfo(@"InMobi interstitial did load");
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];
}

-(void)interstitialDidReceiveAd:(IMInterstitial *)interstitial{
    MPLogInfo(@"InMobi Ad Server responded with an Ad");
}

-(void)interstitial:(IMInterstitial*)interstitial didFailToLoadWithError:(IMRequestStatus*)error {
    MPLogInfo(@"InMobi interstitial did fail with error: %@", error);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:(NSError *)error];
}

-(void)interstitialWillPresent:(IMInterstitial*)interstitial {
    MPLogInfo(@"InMobi interstitial will present");
    [self.delegate interstitialCustomEventWillAppear:self];
}

-(void)interstitialDidPresent:(IMInterstitial *)interstitial {
    MPLogInfo(@"InMobi interstitial did present");
    [self.delegate interstitialCustomEventDidAppear:self];
}

-(void)interstitial:(IMInterstitial*)interstitial didFailToPresentWithError:(IMRequestStatus*)error {
    MPLogInfo(@"InMobi interstitial failed to present with error: %@", error);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:(NSError *)error];
}

-(void)interstitialWillDismiss:(IMInterstitial*)interstitial {
    MPLogInfo(@"InMobi interstitial will dismiss");
    [self.delegate interstitialCustomEventWillDisappear:self];
}

-(void)interstitialDidDismiss:(IMInterstitial*)interstitial {
    MPLogInfo(@"InMobi interstitial did dismiss");
    [self.delegate interstitialCustomEventDidDisappear:self];
}

-(void)interstitial:(IMInterstitial*)interstitial didInteractWithParams:(NSDictionary*)params {
    MPLogInfo(@"InMobi interstitial was tapped");
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

-(void)interstitial:(IMInterstitial*)interstitial rewardActionCompletedWithRewards:(NSDictionary*)rewards {
    if(rewards!=nil){
        NSLog(@"InMobi interstitial reward action completed with rewards: %@", [rewards description]);
    }
}

-(void)userWillLeaveApplicationFromInterstitial:(IMInterstitial*)interstitial {
    MPLogInfo(@"InMobi interstitial will leave application");
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

@end
