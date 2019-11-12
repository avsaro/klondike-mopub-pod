//
//  AerServCustomNativeAdRenderer.m
//  ASMoPubSDKSampleApp
//
//  Created by Albert Zhu on 7/20/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import "AerServCustomNativeAdRenderer.h"
#import "AerServCustomNativeAdRendererSettings.h"

NSString* const kAerServCustomEventNativeAdStr = @"AerServCustomEventNativeAd";

@interface AerServCustomNativeAdRenderer ()

@property (nonatomic, strong) UIView<MPNativeAdRendering> *adView;
@property (nonatomic, strong) id<MPNativeAdAdapter> adapter;
@property (nonatomic, readwrite, copy) MPNativeViewSizeHandler viewSizeHandler;
@property (nonatomic, assign) Class renderingViewClass;

@end

@implementation AerServCustomNativeAdRenderer

- (void)dealloc {
    [_adView removeFromSuperview];
    _adView = nil;
    _adapter = nil;
}

+ (MPNativeAdRendererConfiguration*)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings {
    MPNativeAdRendererConfiguration* config = [MPNativeAdRendererConfiguration new];
    config.rendererClass = [AerServCustomNativeAdRenderer class];
    config.rendererSettings = rendererSettings;
    config.supportedCustomEvents = @[kAerServCustomEventNativeAdStr];
    return config;
}

- (instancetype)initWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings {
    if(self = [super init]) {
        AerServCustomNativeAdRendererSettings* settings = (AerServCustomNativeAdRendererSettings*)rendererSettings;
        _viewSizeHandler = settings.viewSizeHandler;
        _renderingViewClass = settings.renderingViewClass;
    }
    return self;
}

#pragma mark - Render View

- (void)loadAndShowAssetsForAdapter {
    __weak AerServCustomNativeAdRenderer* renderer = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if([renderer.adView respondsToSelector:@selector(nativeMainTextLabel)] && renderer.adView.nativeMainTextLabel) {
            renderer.adView.nativeMainTextLabel.hidden = NO;
            renderer.adView.nativeMainTextLabel.text = renderer.adapter.properties[kAdTextKey];
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeTitleTextLabel)] && renderer.adView.nativeTitleTextLabel) {
            renderer.adView.nativeTitleTextLabel.hidden = NO;
            renderer.adView.nativeTitleTextLabel.text = renderer.adapter.properties[kAdTitleKey];
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeCallToActionTextLabel)] && renderer.adView.nativeCallToActionTextLabel) {
            renderer.adView.nativeCallToActionTextLabel.hidden = NO;
            renderer.adView.nativeCallToActionTextLabel.text = renderer.adapter.properties[kAdCTATextKey];
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeMainImageView)] && renderer.adView.nativeMainImageView) {
            renderer.adView.nativeMainImageView.hidden = NO;
            renderer.adView.nativeMainImageView.image = renderer.adapter.properties[kAdMainImageKey];
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeIconImageView)] && renderer.adView.nativeIconImageView) {
            renderer.adView.nativeIconImageView.hidden = NO;
            renderer.adView.nativeIconImageView.image = renderer.adapter.properties[kAdIconImageKey];
        }
        
        // See if the ad contains a star rating and notify the view if it does.
        if([renderer.adView respondsToSelector:@selector(layoutStarRating:)]) {
            NSNumber *starRatingNum = renderer.adapter.properties[kAdStarRatingKey];
            
            if([starRatingNum isKindOfClass:[NSNumber class]] &&
               starRatingNum.floatValue >= kStarRatingMinValue &&
               starRatingNum.floatValue <= kStarRatingMaxValue) {
                [renderer.adView layoutStarRating:starRatingNum];
            }
        }
    });
}

- (void)hideAssetsForAdapter {
    __weak AerServCustomNativeAdRenderer* renderer = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if([renderer.adView respondsToSelector:@selector(nativeMainTextLabel)] && renderer.adView.nativeMainTextLabel) {
            renderer.adView.nativeMainTextLabel.hidden = YES;
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeTitleTextLabel)] && renderer.adView.nativeTitleTextLabel) {
            renderer.adView.nativeTitleTextLabel.hidden = YES;
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeCallToActionTextLabel)] && renderer.adView.nativeCallToActionTextLabel) {
            renderer.adView.nativeCallToActionTextLabel.hidden = YES;
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeMainImageView)] && renderer.adView.nativeMainImageView) {
            renderer.adView.nativeMainImageView.hidden = YES;
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeIconImageView)] && renderer.adView.nativeIconImageView) {
            renderer.adView.nativeIconImageView.hidden = YES;
        }
        
        if([renderer.adView respondsToSelector:@selector(nativeVideoView)] && renderer.adView.nativeVideoView) {
            renderer.adView.nativeVideoView.hidden =YES;
        }
    });
}

- (void)attemptToLoadAssets {
    if(self.adapter.properties) {
        [self loadAndShowAssetsForAdapter];
    } else {
        [self hideAssetsForAdapter];
        __weak AerServCustomNativeAdRenderer* renderer = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [renderer attemptToLoadAssets];
        });
    }
}

- (UIView*)retrieveViewWithAdapter:(id<MPNativeAdAdapter>)adapter error:(NSError **)error {
    if (!adapter) {
        if (error) {
            *error = MPNativeAdNSErrorForRenderValueTypeError();
        }
        return nil;
    }
    
    // create ad view and set autoresizing mask
    if ([self.renderingViewClass respondsToSelector:@selector(nibForAd)]) {
        self.adView = (UIView<MPNativeAdRendering> *)[[[self.renderingViewClass nibForAd] instantiateWithOwner:nil options:nil] firstObject];
    } else {
        self.adView = [[self.renderingViewClass alloc] init];
    }
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.adapter = adapter;
    [self attemptToLoadAssets];
    
    return self.adView;
}

@end
