//
//  InMobiNativeCustomEvent.h
//  InMobiMopubSampleApp
//
//  Created by Niranjan Agrawal on 28/10/15.
//
//

//#ifndef InMobiNativeCustomEvent_h
//#define InMobiNativeCustomEvent_h
//
//#endif /* InMobiNativeCustomEvent_h */
//
//#import

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPNativeCustomEvent.h"
#endif

#import <InMobiSDK/IMNative.h>

@interface InMobiNativeCustomEvent : MPNativeCustomEvent <IMNativeDelegate>

@end
