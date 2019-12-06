//
//  AerServCustomEventRewardedInterstitial.m
//  AerservFabricSampleApp
//
//  Created on 4/4/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventRewardedInterstitial.h"
#import "AerServCustomEventUtils.h"
#import "AerServBidder.h"
#import "AerServBidObject.h"
#import "MPInterstitialAdController.h"

@interface AerServCustomEventRewardedInterstitial () <ASInterstitialViewControllerDelegate>

@property (nonatomic, strong) ASInterstitialViewController* asInterstitial;
@property (nonatomic, assign) BOOL didPreload;

@end

@implementation AerServCustomEventRewardedInterstitial

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary*)info {
    NSLog(@"AerServCustomEventRewardedInterstitial, requestRewardedVideoWithCustomEventInfo - info: %@", info);
    @try {
        // call init if necessary
        id appId = [info objectForKey:kAppId]?[info objectForKey:kAppId]:[info objectForKey:kSiteId];
        if(appId) {
            [AerServCustomEventUtils initWithAppId:[appId isKindOfClass: [NSString class]]?appId:[appId stringValue]];
        }
        
        // check if ad exists in bidding info or not
        NSString* placement = [info objectForKey:kPlacement];
        NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
        AerServBidObject* bidObject = biddingInfo[placement];
        if([bidObject isKindOfClass:[AerServBidObject class]] &&
           [bidObject.asInterstitial isKindOfClass:[ASInterstitialViewController class]]) {
            // ad exists, pull it out from bidding info and notify of load
            NSLog(@"AerServCustomEventRewardedInterstitial, requestRewardedVideoWithCustomEventInfo: - Aerserv Bid Rewarded is already loaded.Skipping the loading part");
            self.asInterstitial = bidObject.asInterstitial;
            self.asInterstitial.delegate = self;
            self.didPreload = YES;
            [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
        } else {
            // no ad exists, load a new interstitial view controller
            self.asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:self];
            self.asInterstitial.isPreload = YES;
            self.didPreload = NO;
            [self.asInterstitial loadAd];
        }
    } @catch(NSException* e) {
        MPLogError(@"AerServ rewarded interstitial failed to load with error: %@", e);
        [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
    }
}

- (BOOL)hasAdAvailable {
    return self.didPreload;
}

- (void)presentRewardedVideoFromViewController:(UIViewController*)viewController {
    [self.asInterstitial showFromViewController:viewController];
}

- (void)handleCustomEventInvalidated {
    _asInterstitial = nil;
}

- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial loaded.");
    self.didPreload = YES;
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController*)viewController withError:(NSError*)error {
    MPLogInfo(@"AerServ rewarded interstitial failed: %@", error);
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
}

- (void)interstitialViewControllerWillAppear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial will appear.");
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial did appear.");
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
}

- (void)interstitialViewControllerAdImpression:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewrded interstitial received ad impression.");
    NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
    biddingInfo[viewController.placementID] = nil;
    [AerServBidder getSharedBidder].rewardedKeywords = nil;
}

- (void)interstitialViewControllerWillDisappear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial will disappear.");
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
}

- (void)interstitialViewControllerDidDisappear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial did disappear.");
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ rewarded interstitial was clicked.");
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
}

- (void)interstitialViewControllerDidVirtualCurrencyReward:(ASInterstitialViewController *)viewController vcData:(NSDictionary *)vcData {
    MPLogInfo(@"AerServ rewarded interstitial did reward: %@", vcData);
    MPRewardedVideoReward* vcReward = [[MPRewardedVideoReward alloc] initWithCurrencyType:vcData[@"name"] amount:vcData[@"rewardAmount"]];
    [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:vcReward];
}

- (void)dealloc {
    _asInterstitial = nil;
}

@end
