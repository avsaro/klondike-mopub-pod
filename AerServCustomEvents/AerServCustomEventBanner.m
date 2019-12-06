//
//  AerServCustomEventBanner.m
//
//  Copyright (c) 2015 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventBanner.h"
#import "AerServCustomEventUtils.h"
#import "AerServBidder.h"
#import "AerServBidObject.h"
#import "MPAdView.h"

@interface AerServCustomEventBanner () <ASAdViewDelegate>

@property (nonatomic, strong) ASAdView* asBanner;

@end

@implementation AerServCustomEventBanner

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary*)info {
    NSLog(@"AerServCustomEventBanner, requestAdWithSize:customEventInfo: - info: %@", info);
    @try {
        // call init if necessary
        id appId = [info objectForKey:kAppId]?[info objectForKey:kAppId]:[info objectForKey:kSiteId];
        if(appId) {
            [AerServCustomEventUtils initWithAppId:[appId isKindOfClass:[NSString class]]?appId:[appId stringValue]];
        }
        
        // check if ad exists in bidding info or not
        NSString* placement = [info objectForKey:kPlacement];
        NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
        AerServBidObject* bidObject = biddingInfo[placement];
        if([bidObject isKindOfClass:[AerServBidObject class]] &&
           [bidObject.asBanner isKindOfClass:[ASAdView class]]) {
            // ad exists, pull it out from bidding info and notify of load
            NSLog(@"AerServCustomEventBanner, requestAdWithSize:customEventInfo: - Aerserv Bid Banner is already loaded.Skipping the loading part");
            self.asBanner = bidObject.asBanner;
            self.asBanner.delegate = self;
            self.asBanner.bannerRefreshTimeInterval = 0;
            self.asBanner.sizeAdToFit = YES;
            [self.delegate bannerCustomEvent:self didLoadAd:self.asBanner];
            [self.asBanner showPreloadedBanner];
        } else{
            // no ad exists, load a new banner ad view
            self.asBanner = [ASAdView viewWithPlacementID:placement andAdSize:size];
            self.asBanner.delegate = self;
            self.asBanner.bannerRefreshTimeInterval = 0;
            self.asBanner.sizeAdToFit = YES;
            [self.asBanner loadAd];
        }
    } @catch(NSException* e) {
        MPLogError(@"AerServ banner failed to load with error: %@", e);
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark - ASAdViewDelegate Protocol Methods

- (void)adViewDidLoadAd:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner loaded.");
    [adView stopAutomaticallyRefreshingContents];
    [self.delegate bannerCustomEvent:self didLoadAd:self.asBanner];
}

- (void)adViewAdImpression:(ASAdView*)adView {
    MPLogInfo(@"AerServ banner received ad impression.");
    NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
    AerServBidObject* bidObject = biddingInfo[adView.placementID];
    if([bidObject isKindOfClass:[AerServBidObject class]] &&
       [bidObject.mpAdView isKindOfClass:[MPAdView class]]) {
        MPAdView* mpAdView = bidObject.mpAdView;
        NSString* updatedKeywords = [bidObject processedKeywords:mpAdView.keywords withRemovalOfPlacement:adView.placementID];
        mpAdView.keywords = [bidObject handleExtraCommasFor:updatedKeywords];
    }
    biddingInfo[adView.placementID] = nil;
}

- (void)adViewDidFailToLoadAd:(ASAdView*)adView withError:(NSError*)error {
    MPLogInfo(@"AerServ banner failed: %@", error);
    [adView stopAutomaticallyRefreshingContents];
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
