//
//  InMobiRewardedCustomEvent.h
//  InMobiMopubSampleApp
//
//  Created by Niranjan Agrawal on 28/10/15.
//
//

#ifndef InMobiRewardedCustomEvent_h
#define InMobiRewardedCustomEvent_h


#endif /* InMobiRewardedCustomEvent_h */

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPRewardedVideoCustomEvent.h"
#endif
#import <InMobiSDK/IMInterstitial.h>

@interface InMobiRewardedCustomEvent : MPRewardedVideoCustomEvent<IMInterstitialDelegate>
@property (nonatomic, retain) IMInterstitial *inMobiInterstitial;

@end
