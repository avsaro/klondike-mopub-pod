//
//  InMobiSDKInitialiser.h
//  InMobiMoPubSampleApp
//
//

#import <Foundation/Foundation.h>

#define RUN_SYNC_ON_MAIN_THREAD(Stuff) \
if ([NSThread currentThread].isMainThread) { \
do { \
Stuff; \
} while (0); \
} \
else { \
dispatch_sync(dispatch_get_main_queue(), ^(void) { \
do { \
Stuff; \
} while (0); \
}); \
}

typedef enum {
    kIMIncorrectAccountID,
    kIMIncorrectPlacemetID
} IMErrorCode;

extern NSString * const kIMErrorDomain;
extern NSString * const kIMPlacementID;
extern NSString * const kIMAccountID;

@interface InMobiSDKInitialiser : NSObject

/**
 * Initialises the InMobi SDK with InMobi's Account ID
 */
+ (void)initialiseSDK:(NSString *)accountId withError:(NSError **)error;

/**
 * Checks if the InMobi SDK is already initialised or not
 */
+ (BOOL)isSDKInitialised;

/**
 * @discussion Update the consent Dictionary in the SDK
 */
+ (void)updateGDPRConsent;

@end
