//
//  AerServCustomEventInterstitial.m
//
//  Copyright (c) 2015 AerServ. All rights reserved.
//

#import "AerServCustomEventInterstitial.h"
#import "AerServSDK/ASInterstitialViewController.h"
#import "AerServCustomEventUtils.h"


@interface AerServCustomEventInterstitial () <ASInterstitialViewControllerDelegate>

@property (nonatomic, strong) ASInterstitialViewController* asInterstitial;

@end

@implementation AerServCustomEventInterstitial

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary*)info {
    @try {
        id appId = [info objectForKey:kAppId]?[info objectForKey:kAppId]:[info objectForKey:kSiteId];
        if(appId) {
            [AerServCustomEventUtils initWithAppId:[appId isKindOfClass: [NSString class]]?appId:[appId stringValue]];
        }
        
        // Instantiate ad
        NSString* placement = [info objectForKey:kPlacement];
        self.asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement
                                                                            withDelegate:self];
        self.asInterstitial.isPreload = YES;
    
        // Load ad
        [self.asInterstitial loadAd];
    }
    @catch(NSException* e) {
        MPLogError(@"AerServ interstitial failed to load with error: %@", e);
        [self.delegate interstitialCustomEvent:self
                      didFailToLoadAdWithError:nil];
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

- (void)dealloc {
    _asInterstitial = nil;
}

@end
