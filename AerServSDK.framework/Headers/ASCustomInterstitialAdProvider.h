//
//  ASCustomInterstitialAdProvider.h
//  AerServSDK
//
//  Copyright (c) 2015 AerServ, LLC. All rights reserved.
//

#import "ASInterstitialAdProvider.h"
#import <Foundation/Foundation.h>

@interface ASCustomInterstitialAdProvider : ASInterstitialAdProvider

@property (readonly, nonatomic, strong) NSTimer* adLoadingTimer;
@property (nonatomic, strong) id ad;

- (id)initWithAdClassName:(NSString*)adClassName;
- (id)initWithAdClassName:(NSString*)adClassName timeout:(NSTimeInterval)timeout;

- (void)adFailed:(NSString*)msg;

- (void)initializePartnerAd;
- (BOOL)hasPartnerAdInitialized;
- (BOOL)hasPartnerAdFailedToInitialize;
- (void)loadPartnerAd;
- (BOOL)hasPartnerAdLoaded;
- (BOOL)hasPartnerAdFailedToLoad;
- (void)showPartnerAd:(UIViewController*)rootViewController;
- (void)terminatePartnerAd;
- (void)cancelAdLoadingTimer;

- (void)asPartnerInterstitialAdDidLoad:(id)ad;
- (void)asPartnerInterstitialAdWillDisappear;
- (void)asPartnerInterstitialAdDidDisappear;
- (void)asPartnerInterstitialAdWillAppear;
- (void)asPartnerInterstitialAdDidAppear;
- (void)asPartnerInterstitialAdWasTouched;
- (void)asPartnerInterstitialVideoCompleted;

@end
