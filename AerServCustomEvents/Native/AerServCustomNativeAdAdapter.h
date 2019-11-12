//
//  AerServCustomNativeAdAdapter.h
//  ASMoPubSDKSampleApp
//
//  Created by Albert Zhu on 7/19/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MoPub.h"

@class ASNativeAdView;

@interface AerServCustomNativeAdAdapter : NSObject <MPNativeAdAdapter>

- (instancetype)initWithAerServNativeAdView:(ASNativeAdView*)adView;
+ (instancetype)customNativeAdWithAerServNativeAdView:(ASNativeAdView*)adView;

@end
