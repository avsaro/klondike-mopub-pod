//
//  IMABMoPubInterstitial.h
//  InMobiMoPubPlugin
//
//  Copyright © 2020 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMABMoPubDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMABMoPubInterstitial : NSObject

- (instancetype)init NS_UNAVAILABLE;
/**
 * Initialize an Interstitial with the given PlacementId
 * @param placementId The placementId for loading the interstitial
 * @param delegate The delegate to receive callbacks
 */
- (instancetype)initWithPlacementId:(long long)placementId delegate:(id<IMABMoPubDelegate>)delegate;
/**
 * Request a bid.
 * @param timeout The timeout for fetching the bid
 * @discussion The bid will be given asynchronously via the IMABMoPubDelegate protocol methods
 */
- (void)requestBid:(NSTimeInterval)timeout;
/**
 * Request a bid.
 * @param ad Mopub interstitial ad object 
 * @param timeout The timeout for fetching the bid
 * @discussion The bid will be given asynchronously via the IMABMoPubDelegate protocol methods
 */
- (void)requestBid:(nullable id)ad timeout:(NSTimeInterval)timeout;

@end

NS_ASSUME_NONNULL_END
