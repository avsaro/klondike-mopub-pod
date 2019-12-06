//
//  ASBannerAdProvider.h
//  AerServSDK
//
//  Copyright (c) 2014 AerServ, LLC. All rights reserved.
//

/*! @header
 * Class that must be implemented to provide banners ads to AerServ. */

#import "ASAdProvider.h"

#import <AVFoundation/AVFoundation.h>

extern NSString* const ASBannerParameter_Parameters;
extern NSString* const ASBannerParameter_HTMLHeaders;
extern NSString* const ASBannerParameter_HTMLData;
extern NSString* const ASBannerParameter_Location;

@class ASAdView;
@class ASMRAIDView;

@protocol ASBannerAdProviderDelegate;

@interface ASBannerAdProvider : ASAdProvider

@property(nonatomic, assign) BOOL hasModal;
@property (nonatomic, weak) id<ASBannerAdProviderDelegate> delegate;

- (void)requestBannerAdWithSize:(CGSize)size;
- (void)rotateToOrientation:(UIInterfaceOrientation)newOrientation withSize:(CGSize)currSize;
- (void)scheduleRefresh;

@end

@protocol ASBannerAdProviderDelegate <NSObject>

- (UIViewController*)viewControllerForPresentingModalView;
- (void)bannerProvider:(ASBannerAdProvider*)provider didFailToLoadAdWithError:(NSError*)error;
- (void)bannerProvider:(ASBannerAdProvider*)provider didLoadAd:(UIView*)ad;
- (void)bannerProvider:(ASBannerAdProvider*)provider willShowAd:(UIView*)ad;
- (void)bannerProviderDidFireAdImpression:(ASBannerAdProvider*)provider;
- (void)bannerProviderWillBeginAction:(ASBannerAdProvider*)provider;
- (void)bannerProviderWillEndAction:(ASBannerAdProvider*)provider;
- (void)bannerProviderWillLeaveApplication:(ASBannerAdProvider*)provider;
- (void)bannerProviderAdChangedSize:(ASBannerAdProvider*)provider;
- (void)bannerProviderAdWasClicked:(ASBannerAdProvider*)provider;
- (void)bannerProviderDidShowAdCompletely:(ASBannerAdProvider*)provider;
- (void)bannerProvider:(ASBannerAdProvider*)provider willChangeFrameTo:(CGRect)newFrame;
- (ASAdView*)bannerProviderWillGetAdView:(ASBannerAdProvider*)provider;
- (UIView*)bannerProviderWillGetContentView:(ASBannerAdProvider*)provider;
- (void)bannerProvider:(ASBannerAdProvider*)provider willSetContentViewToMRAIDView:(ASMRAIDView*)mraidView;
- (void)bannerProvider:(ASBannerAdProvider*)provider didLoadPlayerLayer:(AVPlayerLayer*)pl;
- (void)bannerProvider:(ASBannerAdProvider*)provider willShowSkip:(BOOL)show;
- (void)bannerProviderWillAttemptRefresh:(ASBannerAdProvider*)provider;
- (void)bannerProviderWillGotoBackground:(ASBannerAdProvider*)provider;
- (void)bannerProviderDidReturnToForeground:(ASBannerAdProvider*)provider;
- (void)bannerProvider:(ASBannerAdProvider*)provider didFireAdvertiserEventWithMessage:(NSString*)msg;

@end
