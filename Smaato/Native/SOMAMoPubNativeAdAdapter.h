//
//  SOMAMoPubNativeAdAdapter.h
//  iSoma
//
//  Created by Aman Shaikh on 14.07.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPNativeAdAdapter.h"
#import "MPNativeAd.h"
@interface SOMAMoPubNativeAdAdapter : NSObject<MPNativeAdAdapter>
@property (nonatomic, readonly) NSDictionary *properties;
@property (nonatomic, readonly) NSURL *defaultActionURL;
@property (nonatomic, assign) BOOL isBeaconsCalled;
@property (nonatomic, assign) BOOL isClickTrackersCalled;
@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;
@property UIView* sponsoredInfoView;
- (instancetype)init:(NSDictionary*)properties withDefaultActionURL:(NSURL*)url;
@end
