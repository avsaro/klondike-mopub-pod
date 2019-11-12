//
//  SOMAMoPubBannerAdapter.h
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 02/09/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "MPBannerCustomEvent.h"
#import <iSoma/iSoma.h>

@interface SOMAMoPubBannerAdapter : MPBannerCustomEvent<SOMAAdViewDelegate>
@property(nonatomic, strong) SOMAAdView* somaBanner;
@end
