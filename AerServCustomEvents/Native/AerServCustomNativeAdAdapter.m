//
//  AerServCustomNativeAdAdapter.m
//  ASMoPubSDKSampleApp
//
//  Created by Albert Zhu on 7/19/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>

#import "AerServCustomNativeAdAdapter.h"

@interface AerServCustomNativeAdAdapter () <ASNativeAdCustomDelegate>

@property (nonatomic, strong) ASNativeAdView* nativeAdView;
@property (nonatomic, strong) NSMutableDictionary* mProperties;

@property (nonatomic, strong) NSString* titleStr;
@property (nonatomic, strong) NSString* descStr;
@property (nonatomic, strong) UIImage* iconImg;
@property (nonatomic, strong) UIImage* mainImg;
@property (nonatomic, strong) NSString* callToActionStr;
@property (nonatomic, strong) NSString* ratingStr;
@property (nonatomic, strong) NSString* vastTagStr;

@end

@implementation AerServCustomNativeAdAdapter

@synthesize delegate;
@synthesize properties;
@synthesize defaultActionURL;

- (void)dealloc {
    [_nativeAdView cancel];
    _nativeAdView = nil;
    [_mProperties removeAllObjects];
    _mProperties = nil;
    _titleStr = nil;
    _descStr = nil;
    _iconImg = nil;
    _mainImg = nil;
    _callToActionStr = nil;
    _ratingStr = nil;
    _vastTagStr = nil;
}

- (instancetype)initWithAerServNativeAdView:(ASNativeAdView*)adView {
    if(self = [super init]) {
        _nativeAdView = adView;
        _nativeAdView.customDelegate = self;
        defaultActionURL = nil;
    }
    return self;
}

+ (instancetype)customNativeAdWithAerServNativeAdView:(ASNativeAdView*)adView {
    return [[AerServCustomNativeAdAdapter alloc] initWithAerServNativeAdView:adView];
}

#pragma mark - MPNativeAdapter Protocol Methods

- (NSDictionary*)properties {
    if(!self.mProperties) {
        self.mProperties = [NSMutableDictionary new];
    }
        
    // check for custom assets to populate properties with
    if(self.titleStr && !self.mProperties[kAdTitleKey]) {
        self.mProperties[kAdTitleKey] = self.titleStr;
    }
    
    if(self.descStr && !self.mProperties[kAdTextKey]) {
        self.mProperties[kAdTextKey] = self.descStr;
    }
    
    if(self.iconImg && !self.mProperties[kAdIconImageKey]) {
        self.mProperties[kAdIconImageKey] = self.iconImg;
    }
    
    if(self.mainImg && !self.mProperties[kAdMainImageKey]) {
        self.mProperties[kAdMainImageKey] = self.mainImg;
    }
    
    if(self.callToActionStr && !self.mProperties[kAdCTATextKey]) {
        self.mProperties[kAdCTATextKey] = self.callToActionStr;
    }
    
    if(self.ratingStr && !self.mProperties[kAdStarRatingKey]) {
        self.mProperties[kAdStarRatingKey] = self.ratingStr;
    }
    
    if(self.vastTagStr && !self.mProperties[kVASTVideoKey]) {
        self.mProperties[kVASTVideoKey] = self.vastTagStr;
    }
    
    // check if there's any keys, if none set it back to nil
    if(self.mProperties.allKeys.count == 0) {
        self.mProperties = nil;
    }
    
    // return either nil or regular dictionary
    return !self.mProperties ? nil : [NSDictionary dictionaryWithDictionary:self.mProperties];    
}

- (void)displayContentForURL:(NSURL*)URL rootViewController:(UIViewController*)controller {
    NSURL* url = [self.nativeAdView linkForElement:kNativeElementTypeAdView];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        if([delegate respondsToSelector:@selector(nativeAdWillLeaveApplicationFromAdapter:)]) {
            [delegate nativeAdWillLeaveApplicationFromAdapter:self];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)trackClick {
    [self.nativeAdView fireClickEventForElement:kNativeElementTypeAdView];
    if([delegate respondsToSelector:@selector(nativeAdDidClick:)]) {
        [delegate nativeAdDidClick:self];
    }
}

- (void)willAttachToView:(UIView*)view {
    // fire show attempt tracking event
    [self.nativeAdView showAd];
    
    // fire impression event
    [self.nativeAdView fireImpressionEvent];
    if([delegate respondsToSelector:@selector(nativeAdWillLogImpression:)]) {
        [delegate nativeAdWillLogImpression:self];
    }
}

#pragma mark - ASNativeAdCustomDelegate Protocol Methods -- Correspond to MoPub

- (void)nativeAdView:(ASNativeAdView*)nativeView hasTitle:(NSString*)titleStr {
    self.titleStr = titleStr;
}

- (void)nativeAdView:(ASNativeAdView*)nativeView hasPrimaryDesc:(NSString*)primaryDescStr {
    self.descStr = primaryDescStr;
}

- (void)nativeAdView:(ASNativeAdView*)nativeView hasIconImgUrl:(NSString*)iconImgUrlStr withSize:(CGSize)imgSize {
    if(!self.iconImg) {
        self.iconImg = [self.nativeAdView loadImageWithUrl:iconImgUrlStr];
    }
}

- (void)nativeAdView:(ASNativeAdView*)nativeView hasMainImgUrl:(NSString*)mainImgUrlStr withSize:(CGSize)imgSize {
    if(!self.mainImg) {
        self.mainImg = [self.nativeAdView loadImageWithUrl:mainImgUrlStr];
    }
}

- (void)nativeAdView:(ASNativeAdView*)nativeView hasCallToAction:(NSString*)callToActionStr {
    self.callToActionStr = callToActionStr;
}

- (void)nativeAdView:(ASNativeAdView*)nativeView hasRating:(NSString*)ratingStr {
    self.ratingStr = ratingStr;
}

- (void)nativeAdView:(ASNativeAdView *)nativeView hasVastTag:(NSString*)vastTagStr {
    self.vastTagStr = vastTagStr;
}

#pragma mark - ASNativeAdCustomDelegate Protocol Methods -- Does not correspond to MoPub

- (void)nativeAdView:(ASNativeAdView*)nativeView hasSponsored:(NSString*)sponsoredStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasLikes:(NSString*)likesStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasDownloads:(NSString*)downloadsStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasPrice:(NSString*)priceStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasSalePrice:(NSString*)salePriceStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasPhoneNum:(NSString*)phoneNumStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasStreetAddress:(NSString*)streetAddrStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasSecondaryDesc:(NSString*)secondDescStr { }

- (void)nativeAdView:(ASNativeAdView*)nativeView hasWebsiteUrl:(NSString*)websiteUrlStr { }

@end
