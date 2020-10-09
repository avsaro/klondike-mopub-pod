//
//  InMobiRewardedCustomEvent.h
//  InMobiMoPubPlugin
//  InMobi
//
//  Created by Aaditya Gandhi on 29/06/20.
//  Copyright © 2020 InMobi. All rights reserved.
//


#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPFullscreenAdAdapter.h"
#endif

#import <InMobiSDK/IMInterstitial.h>

NS_ASSUME_NONNULL_BEGIN

@interface InMobiRewardedCustomEvent : MPFullscreenAdAdapter <MPThirdPartyFullscreenAdAdapter, IMInterstitialDelegate>

@end

NS_ASSUME_NONNULL_END
