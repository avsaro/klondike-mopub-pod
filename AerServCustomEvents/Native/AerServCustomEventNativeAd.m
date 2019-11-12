//
//  AerServCustomEventNativeAd.m
//  ASMoPubSDKSampleApp
//
//  Created by Albert Zhu on 7/18/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>

#import "AerServCustomEventNativeAd.h"
#import "AerServCustomNativeAdAdapter.h"
#import "AerServCustomEventUtils.h"

@interface AerServCustomEventNativeAd () <ASNativeAdDelegate>

@property (nonatomic, strong) ASNativeAdView* nativeAdView;
@property (nonatomic, strong) AerServCustomNativeAdAdapter* nativeAdapter;

@end

@implementation AerServCustomEventNativeAd

- (void)dealloc {
    _nativeAdView = nil;
    _nativeAdapter = nil;
}

- (void)requestAdWithCustomEventInfo:(NSDictionary*)info {
    NSString* plc = info[kPlacement];
    
    // setup ASNativeAdView
    self.nativeAdView = [ASNativeAdView new];
    [self.nativeAdView configurePlacement:plc andDelegate:self];
    
    
    // create AerServCustomNativeAdAdapter
    self.nativeAdapter = [AerServCustomNativeAdAdapter customNativeAdWithAerServNativeAdView:self.nativeAdView];
    
    // preload native ad here
    self.nativeAdView.isPreload = YES;
    [self.nativeAdView loadAd];
}

#pragma mark - ASNativeAdDelegate Protocol Methods

- (UIViewController*)viewControllerForPresentingNativeAdView {
    return [[[UIApplication sharedApplication] keyWindow] rootViewController];
}

- (void)nativeAd:(ASNativeAdView*)nativeAdView didFailToLoadWithError:(NSError*)error {
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)nativeAdDidPreload:(ASNativeAdView*)nativeAdView {
    // create mopub native ad
    MPNativeAd* nativeAd = [[MPNativeAd alloc] initWithAdAdapter:self.nativeAdapter];
    
    // notify delegate of native custom event loading
    [self.delegate nativeCustomEvent:self didLoadAd:nativeAd];
}

@end
