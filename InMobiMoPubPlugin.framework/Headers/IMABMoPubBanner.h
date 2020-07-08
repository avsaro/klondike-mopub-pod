//
//  IMABMoPubBanner.h
//  InMobiMoPubPlugin
//
//  Copyright © 2020 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMABMoPubDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMABMoPubBanner : NSObject

- (instancetype)init NS_UNAVAILABLE;
/**
 * Initializes an IMBanner instance with the specified placementId and delegate.
 * @param adSize the desired ad size.
 * @param placementId  the placement Id registered on the InMobi portal.
 * @param delegate The delegate to receive callbacks
 */
- (instancetype)initWithSize:(CGSize)adSize placementId:(long long)placementId delegate:(id<IMABMoPubDelegate>)delegate;
/**
 * Request a bid.
 * @param timeout The timeout for fetching the bid
 * @discussion The bid will be given asynchronously via the IMABMoPubDelegate protocol methods
 */
- (void)requestBid:(NSTimeInterval)timeout;
/**
 * Request a bid.
 * @param ad Mopub Banner ad object
 * @param timeout The timeout for fetching the bid
 * @discussion The bid will be given asynchronously via the IMABMoPubDelegate protocol methods
 */
- (void)requestBid:(nullable id)ad timeout:(NSTimeInterval)timeout;

@end

NS_ASSUME_NONNULL_END
