//
//  DTBAdResponse.h
//  DTBiOSSDK
//
//  Created by Singh, Prashant Bhushan on 10/4/15.
//  Copyright © 2015 amazon.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTBAdSize.h"

typedef enum {
    NETWORK_ERROR = 81,
    NETWORK_TIMEOUT,
    NO_FILL,
    INTERNAL_ERROR,
    REQUEST_ERROR
} DTBAdError;

@interface DTBAdResponse : NSObject

@property (nonatomic) NSString *bidId;

@property (nonatomic) BOOL isVideo;

- (void)addDTBPricePoint: (id) pp;

- (NSString *)hostname;

- (NSArray *)adSizes;

- (NSString *)pricePoints:(DTBAdSize *)adSize;

- (NSString *)defaultPricePoints;

- (NSDictionary *)customTargetting;

- (NSString *)keywordsForMopub;


@end
