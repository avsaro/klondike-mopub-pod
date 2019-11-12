//
//  SOMAMoPubInterstitialAdapter.h
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 09/10/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MPInterstitialCustomEvent.h"
#import <iSoma/iSoma.h>

@interface SOMAMoPubInterstitialAdapter : MPInterstitialCustomEvent<SOMAAdViewDelegate>
@property(nonatomic, strong) SOMAInterstitialAdView* adview;
@end
