//
//  InneractiveNativeAdRenderingAdapterView.m
//  IASDKClient
//
//  Created by Inneractive on 31/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "InneractiveNativeAdRenderingAdapterView.h"

@interface InneractiveNativeAdRenderingAdapterView ()

@end

@implementation InneractiveNativeAdRenderingAdapterView {}

#pragma mark - Inits

- (instancetype)initWithAdView:(UIView<MPNativeAdRendering> *)adView isDynamicSize:(BOOL)isDynamicSize {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, adView.frame.size.width, adView.frame.size.height)];
    
    if (self) {
        super.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _adView = adView;
        _isDynamicSize = @(isDynamicSize);
    }
    
    return self;
}

#pragma mark - IAInterfaceNativeRenderer

- (UIView * _Nonnull)IAMainAssetSuperview {
    self.adView.frame = ((UIView *)self).frame; // casting is needed here, since for some reason the Xcode shows a warning;
	[self addSubview:self.adView];

    const BOOL hasVideoPlaceholder = [self.adView respondsToSelector:@selector(nativeVideoView)];
    const BOOL hasImagePlaceholder = [self.adView respondsToSelector:@selector(nativeMainImageView)];
    UIView *mainAssetPlaceholder = nil;
    // if ad is video ad AND rendering view class implements 'nativeVideoView', then load video into 'nativeVideoView';
    if (self.isVideoAd && hasVideoPlaceholder) {
        mainAssetPlaceholder = self.adView.nativeVideoView;
        
        if (hasImagePlaceholder) {
            self.adView.nativeMainImageView.hidden = YES;
        }
    } // else, if ad is video ad, but there is no dedicated video view OR ad is image ad, then load (add subview) video/image into 'nativeMainImageView';
    else if (hasImagePlaceholder) {
		mainAssetPlaceholder = self.adView.nativeMainImageView;
		
        if (hasVideoPlaceholder) {
            self.adView.nativeVideoView.hidden = YES;
        }
    }
 
    mainAssetPlaceholder.hidden = NO;
    mainAssetPlaceholder.userInteractionEnabled = YES;

	_mainMediaView = mainAssetPlaceholder;

    if (_isDynamicSize) {
        // implement any additional logic, if needed;
    }
    
    if (!mainAssetPlaceholder) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"<Inneractive> IAMainAssetSuperview must return an object." userInfo:nil];
    }
	
	return mainAssetPlaceholder;
}

- (UILabel * _Nullable)IATitleAsset {
	UILabel *titleLabel = nil;
	
	if ([self.adView respondsToSelector:@selector(nativeTitleTextLabel)]) {
        titleLabel = self.adView.nativeTitleTextLabel;
    }
	return titleLabel;
}

- (UIImageView * _Nullable)IAIconAsset {
	UIImageView *iconView = nil;
	
	if ([self.adView respondsToSelector:@selector(nativeIconImageView)]) {
        iconView = self.adView.nativeIconImageView;
    }
	return iconView;
}

- (UILabel * _Nullable)IADescriptionAsset {
	UILabel *descriptionLabel = nil;
	
	if ([self.adView respondsToSelector:@selector(nativeMainTextLabel)]) {
        descriptionLabel = self.adView.nativeMainTextLabel;
    }
	return descriptionLabel;
}

- (UILabel * _Nullable)IACallToActionAsset {
	UILabel *ctaLabel = nil;
	
	if ([self.adView respondsToSelector:@selector(nativeCallToActionTextLabel)]) {
        ctaLabel = self.adView.nativeCallToActionTextLabel;
    }
	return ctaLabel;
}

#pragma mark - View lifecycle

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize adViewSize = [self.adView sizeThatFits:size];
    
    self.bounds = CGRectMake(0.0f, 0.0f, adViewSize.width, adViewSize.height);
    
    return adViewSize;
}

@end
