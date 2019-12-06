//
//  AerServCustomEventInterstitial.m
//
//  Copyright (c) 2015 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventInterstitial.h"
#import "AerServCustomEventUtils.h"
#import "AerServBidder.h"
#import "AerServBidObject.h"
#import "MPInterstitialAdController.h"

@interface AerServCustomEventInterstitial () <ASInterstitialViewControllerDelegate>

@property (nonatomic, strong) ASInterstitialViewController* asInterstitial;

@end

@implementation AerServCustomEventInterstitial

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary*)info {
    NSLog(@"AerServCustomEventInterstitial, requestInterstitialWithCustomEventInfo: - info: %@", info);
    @try {
        // call init if necessary
        id appId = [info objectForKey:kAppId]?[info objectForKey:kAppId]:[info objectForKey:kSiteId];
        if(appId) {
            [AerServCustomEventUtils initWithAppId:[appId isKindOfClass: [NSString class]]?appId:[appId stringValue]];
        }
        
        // check if ad exists in bidding info or not
        NSString* placement = [info objectForKey:kPlacement];
        NSMutableDictionary* aerservBiddingInfo = [AerServBidder getAerservBiddingInfo];
        AerServBidObject* bidObject = aerservBiddingInfo[placement];
        if([bidObject isKindOfClass:[AerServBidObject class]] &&
           [bidObject.asInterstitial isKindOfClass:[ASInterstitialViewController class]]) {
            // ad exists, pull it out from bidding info and notify of load
            NSLog(@"AerServCustomEventInterstitial, requestInterstitialWithCustomEventInfo: - Aerserv Bid Interstitial is already loaded.Skipping the loading part");
            self.asInterstitial = bidObject.asInterstitial;
            [self.asInterstitial setDelegate:self];
            [self.delegate interstitialCustomEvent:self didLoadAd:self.asInterstitial];
        } else {
            // no ad exists, load a new interstitial view controller
            self.asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:self];
            self.asInterstitial.isPreload = YES;
            [self.asInterstitial loadAd];
        }
    } @catch(NSException* e) {
        MPLogError(@"AerServ interstitial failed to load with error: %@", e);
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController*)rootViewController {
    __weak ASInterstitialViewController* weakInterstitial = self.asInterstitial;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakInterstitial showFromViewController:rootViewController];
    });
}

- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial loaded.");
    [self.delegate interstitialCustomEvent:self didLoadAd:viewController];
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController*)viewController withError:(NSError *)error {
    MPLogInfo(@"AerServ interstitial failed: %@", error);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)interstitialViewControllerWillAppear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial will appear.");
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial did appear.");
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)interstitialViewControllerAdImpression:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial received ad impression.");
    NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
    AerServBidObject* bidObject = biddingInfo[viewController.placementID];
    if([bidObject isKindOfClass:[AerServBidObject class]] &&
       [bidObject.mpInterstitialAdController isKindOfClass:[MPInterstitialAdController class]]) {
        MPInterstitialAdController* mpInter = bidObject.mpInterstitialAdController;
        NSString* updatedKeywords = [bidObject processedKeywords:mpInter.keywords withRemovalOfPlacement:viewController.placementID];
        mpInter.keywords = [bidObject handleExtraCommasFor:updatedKeywords];
    }
    biddingInfo[viewController.placementID] = nil;
}

- (void)interstitialViewControllerWillDisappear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial will disappear");
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)interstitialViewControllerDidDisappear:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial did disappear.");
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController*)viewController {
    MPLogInfo(@"AerServ interstitial clicked.");
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didLoadAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    MPLogInfo(@"AerServ Interstitial ad did load with transaction info: %@", transactionInfo);
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didShowAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    MPLogInfo(@"AerServ Interstitial ad did show with transaction info: %@", transactionInfo);
}

- (void)dealloc {
    _asInterstitial = nil;
}

@end
