//
//  InneractiveNativeAdRenderer.m
//  IASDKClient
//
//  Created by Inneractive on 30/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "InneractiveNativeAdRenderer.h"

#import "MPNativeAdError.h"

#import "InneractiveNativeAdRenderingAdapterView.h"
#import "InneractiveNativeAdAdapter.h"
#import "InneractiveNativeAdRendererSettings.h"
#import "MPNativeAdRendererConfiguration.h"
#import "InneractiveNativeCustomEvent.h"

#import "MPNativeAdRendererConstants.h"
#import "MPLogging.h"

#import <IASDKCore/IASDKCore.h>
#import <IASDKVideo/IASDKVideo.h>
#import <IASDKNative/IASDKNative.h>

@interface InneractiveNativeAdRenderer ()

@property (nonatomic, strong) InneractiveNativeAdRenderingAdapterView *nativeAdView;
@property (nonatomic, strong) InneractiveNativeAdAdapter *adapter;
@property (nonatomic) Class renderingViewClass;

@end

@implementation InneractiveNativeAdRenderer {}

#pragma mark - MPNativeAdRenderer

+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(InneractiveNativeAdRendererSettings *)rendererSettings {
    MPNativeAdRendererConfiguration *config = [[MPNativeAdRendererConfiguration alloc] init];
    
    config.rendererClass = self.class;
    config.rendererSettings = rendererSettings;
    config.supportedCustomEvents = @[NSStringFromClass(InneractiveNativeCustomEvent.class)];
    
    return config;
}

- (instancetype)initWithRendererSettings:(InneractiveNativeAdRendererSettings *)rendererSettings {
    self = [super init];
    
    if (self) {
        _renderingViewClass = rendererSettings.renderingViewClass;
        _viewSizeHandler = [rendererSettings.viewSizeHandler copy];
    }
    
    return self;
}

- (UIView *)retrieveViewWithAdapter:(InneractiveNativeAdAdapter *)adapter error:(NSError **)error {
    if (!adapter || ![adapter isKindOfClass:InneractiveNativeAdAdapter.class]) {
        if (error) {
            *error = MPNativeAdNSErrorForRenderValueTypeError();
        }
        
        return nil;
    }
    
    _adapter = adapter;
    
    UIView<MPNativeAdRendering> *adView = nil;

    if ([self.renderingViewClass respondsToSelector:@selector(nibForAd)]) {
        adView = (UIView<MPNativeAdRendering> *)[[[self.renderingViewClass nibForAd] instantiateWithOwner:nil options:nil] firstObject];
    } else {
        adView = [[self.renderingViewClass alloc] init];
    }
    
    adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    BOOL isDynamicSize = NO;
    
    if (self.viewSizeHandler) {
        CGSize size = self.viewSizeHandler(UIScreen.mainScreen.bounds.size.width);
        
        isDynamicSize = (size.height == MPNativeViewDynamicDimension);
    }
    
    InneractiveNativeAdRenderingAdapterView *newNativeAdView = [[InneractiveNativeAdRenderingAdapterView alloc] initWithAdView:adView isDynamicSize:isDynamicSize];
	newNativeAdView.isVideoAd = adapter.isVideoAd;
    
    if (!self.nativeAdView || !self.nativeAdView.superview) { // dynamic size support: update views hierarchy only if was not updated already;
        MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.adapter.class)], nil);
        // Inneractive Ad SDK will manage all assets data on its behalf
		[self.adapter.nativeUnitController showAdInNativeRenderer:newNativeAdView];
		
        _nativeAdView = newNativeAdView;
        self.adapter.mainMediaView = self.nativeAdView.mainMediaView;
    }
    
    return newNativeAdView;
}

- (void)adViewWillMoveToSuperview:(UIView *)superview {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.adapter.class)], nil);
    // do nothing; this is an empty implementation, otherwise there will be a crash,
    // because this is 'optional' interface method, but MoPub will invoke it
    // anyway, no matter it is implemented or not;
}

- (void)nativeAdTapped {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.adapter.class)], nil);
}

@end
