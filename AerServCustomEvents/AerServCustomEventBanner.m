//
//  AerServCustomEventBanner.m
//
//  Copyright (c) 2015 AerServ. All rights reserved.
//

#import "AerServCustomEventBanner.h"
#import "AerServSDK/ASAdView.h"
#import "AerServCustomEventUtils.h"

@interface AerServCustomEventBanner () <ASAdViewDelegate>

@property (nonatomic, strong) ASAdView* asBanner;

@end

@implementation AerServCustomEventBanner

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary*)info {
    @try {
        id appId = [info objectForKey:kAppId]?[info objectForKey:kAppId]:[info objectForKey:kSiteId];
        if(appId) {
            [AerServCustomEventUtils initWithAppId:[appId isKindOfClass: [NSString class]]?appId:[appId stringValue]];
        }
        
        // Instantiate ad
        NSString* placement = [info objectForKey:kPlacement];
    
        self.asBanner = [ASAdView viewWithPlacementID:placement andAdSize:size];
        self.asBanner.delegate = self;
        self.asBanner.bannerRefreshTimeInterval = 0;
        self.asBanner.sizeAdToFit = YES;
    
        // Load ad
        [self.asBanner loadAd];
    }
    @catch(NSException* e) {
        MPLogError(@"AerServ banner failed to load with error: %@", e);
        [self.delegate bannerCustomEvent:self
                didFailToLoadAdWithError:nil];
    }
}

- (void)adViewDidLoadAd:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner loaded.");
    [self.delegate bannerCustomEvent:self didLoadAd:self.asBanner];
}

- (void)adViewDidFailToLoadAd:(ASAdView*)adView withError:(NSError*)error {
    MPLogInfo(@"AerServ banner failed: %@", error);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)adWasClicked:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner was clicked");
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)willPresentModalViewForAd:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner will appear");
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)didDismissModalViewForAd:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner did dismiss.");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)willLeaveApplicatonFromAd:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner leaving application.");
}

- (UIViewController*)viewControllerForPresentingModalView {
    return [self.delegate viewControllerForPresentingModalView];
}

- (void)dealloc {
    [_asBanner cancel];
    _asBanner = nil;
}

@end
