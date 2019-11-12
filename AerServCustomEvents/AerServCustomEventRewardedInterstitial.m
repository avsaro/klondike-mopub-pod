//
//  AerServCustomEventRewardedInterstitial.m
//  AerservFabricSampleApp
//
//  Created by Hall To on 4/4/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import "AerServCustomEventRewardedInterstitial.h"
#import "AerServSDK/ASInterstitialViewController.h"
#import "AerServCustomEventUtils.h"

@interface AerServCustomEventRewardedInterstitial () <ASInterstitialViewControllerDelegate>

@property (nonatomic, strong) ASInterstitialViewController* asInterstitial;
@property (nonatomic, assign) BOOL didPreload;

@end

@implementation AerServCustomEventRewardedInterstitial

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary*)info {
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
        self.didPreload = NO;
    
        // Load ad
        [self.asInterstitial loadAd];
    }
    @catch(NSException* e) {
        MPLogError(@"AerServ rewarded interstitial failed to load with error: %@", e);
        [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self
                                                            error:nil];
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
