//
//  IMABMoPubDelegate.h
//  InMobiMoPubPlugin
//
//  Copyright © 2020 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IMABMoPubDelegate <NSObject>

/**
 * Notifies Bid is recieved successfully with transaction keyword.
 * @param mpAd MoPub ad object passed in requestBid. It can be either MPAdView or MPInterstitialAdController type
 *          It will be null if the MoPub ad object was not passed while calling the requestBid API
 * @param imAd InMobi ad Object for which the keyword is recieved. In case of nil mpAd, set imAd inside localExtras of mopub
 *          ad object. Kindly refer intergation document.
 * @param keyword  keyword derived from the bid received.
 */
- (void)bidReceivedFor:(nullable id)mpAd andInMobiAd:(id)imAd withTransactionInfo:(NSString*)keyword;

/**
 * Notifies Bid fetch is failed with error.
 * @param ad MoPub ad object passed in requestBid. It can be either MPAdView or MPInterstitialAdController type
 *          It will be null if the MoPub ad object was not passed while calling the requestBid API
 * @param error error which caused failure.
 */
- (void)bidFailedFor:(nullable id)ad withError:(NSError*)error;

@end

NS_ASSUME_NONNULL_END
