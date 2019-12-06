//
//  AerservBidder.h
//
//  Created on 18/06/18.
//

#import <Foundation/Foundation.h>
#import "MPInterstitialAdController.h"
#import "MPAdView.h"
#import "AerServBidListener.h"

@interface AerServBidder : NSObject

@property (nonatomic, strong) NSString* rewardedKeywords;

+ (NSMutableDictionary*)getAerservBiddingInfo;
+ (AerServBidder*)getSharedBidder;
- (void)updateBidPriceForInterstitial:(NSString*)placement mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener;
- (void)updateBidPriceForBanner:(NSString*)placement mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener;
- (void)updateBidPriceForRewarded:(NSString*)placement andUserId:(NSString*)userId aerservBidListener:(id)aerservBidListener;

@end
