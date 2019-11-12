//
//  DTBAdLoader.h
//  DTBiOSSDK
//
//  Created by Singh, Prashant Bhushan on 10/2/15.
//  Copyright © 2015 amazon.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTBAdSize.h"
#import "DTBAdCallback.h"

#define A9_BID_ID_KEY @"amzn_b"
#define A9_HOST_KEY @"amzn_h"
#define A9_PRICE_POINTS_KEY @"amznslots"
#define A9_VID_KEY @"amzn_vid";

@interface DTBAdLoader : NSObject

- (void)setSizes:(DTBAdSize *)size,... NS_REQUIRES_NIL_TERMINATION;

- (void)setAdSizes:(NSArray *)adSizes;

- (void)putCustomTarget: (NSString *)value withKey: (NSString *)key;

- (void)loadAd: (id<DTBAdCallback>) callback;

- (void)setAutoRefresh;

- (void)stop;

- (void)setAutoRefresh: (int)seconds;

@end
