//
//  AerservBidder.m
//
//  Created on 18/06/18.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServBidder.h"
#import "AerServCustomEventUtils.h"
#import "AerServBidObject.h"

NSString* const kASIMMoPubDefaultUserID = @"ASIMMoPubDefaultUserID";

@interface AerServBidder ()

@property (nonatomic, strong) NSMutableDictionary* aerservBiddinfgInfo;

@end

@implementation AerServBidder

#pragma mark Singleton Method for AerservBidder

+ (AerServBidder*)getSharedBidder {
    static AerServBidder *aerservBidder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"AerServBidder, getSharedBidder:Initialising the Aerserv Bidder");
        aerservBidder = [AerServBidder new];
        aerservBidder.aerservBiddinfgInfo = [NSMutableDictionary new];
    });
    return aerservBidder;
}

+ (NSMutableDictionary*)getAerservBiddingInfo {
    AerServBidder* bidder = [AerServBidder getSharedBidder];
    return bidder.aerservBiddinfgInfo;
}

- (void)updateBidPriceForInterstitial:(NSString*)placement mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener {
    @try {
        if(placement && ![placement isEqualToString:@""]) {
            ASInterstitialViewController* asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:nil];
            asInterstitial.isPreload = YES;
            AerServBidObject* bidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asInterstitial:asInterstitial mopubInterstitial:mpInterstitialAdController aerservBidListener:aerservBidListener];
            NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
            biddingInfo[placement] = bidObject;
        } else {
            NSLog(@"AerServBidder, updateBidPriceForInterstitial:aerservBidListener: - Aerserv placement cannot be null or empty");
        }
    } @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForInterstitial:aerservBidListener: - AerServ bid interstitial ad failed to load with exception: %@", e);
    }
}

- (void)updateBidPriceForBanner:(NSString*)placement mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener {
    @try {
        if(placement && ![placement isEqualToString:@""]) {
            ASAdView* asBanner = [ASAdView viewWithPlacementID:placement andAdSize:ASBannerSize];
            asBanner.bannerRefreshTimeInterval = 0;
            asBanner.sizeAdToFit = YES;
            asBanner.isPreload = YES;
            AerServBidObject* bidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asBanner:asBanner mopubBanner:adView aerservBidListener:aerservBidListener];
            NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
            biddingInfo[placement] = bidObject;
        } else {
            NSLog(@"AerServBidder, updateBidPriceForBanner:aerservBidListener: - Aerserv placement cannot be null or empty");
        }
    } @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForBanner:aerservBidListener: - AerServ bid banner ad failed to load with exception: %@", e);
    }
}

- (void)updateBidPriceForRewarded:(NSString*)placement andUserId:(NSString*)userId aerservBidListener:(id)aerservBidListener {
    @try {
        if(placement && ![placement isEqualToString:@""]) {
            ASInterstitialViewController* asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:nil];
            asInterstitial.userId = userId ? userId : kASIMMoPubDefaultUserID;
            asInterstitial.isPreload = YES;
            AerServBidObject* bidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asRewardedInterstitial:asInterstitial aerservBidListener:aerservBidListener];
            NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
            biddingInfo[placement] = bidObject;
        } else {
            NSLog(@"AerServBidder, updateBidPriceForRewarded:aerservBidListener: - Aerserv placement cannot be null or empty");
        }
    } @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForRewarded:aerservBidListener: - AerServ bid rewarded ad failed to load with exception: %@", e);
    }
}

@end
