//
//  ASNativeAdView.h
//  AerServSDK
//
//  Created by Albert Zhu on 4/25/17.
//  Copyright © 2017 AerServ, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASConstants.h"

/*
 * ASNativeElementType
 *
 * ENUM class to define each of the available native assets. Mostly used for the custom implementation
 * to fire click tracking events or get click through URLs for each native asset.
 */
typedef NS_ENUM(NSInteger, ASNativeElementType) {
    kNativeElementTypeAdView = 0,
    kNativeElementTypeTitle,
    kNativeElementTypeSponsored,
    kNativeElementTypePrimaryDescription,
    kNativeElementTypeMainImage,
    kNativeElementTypeVideo,
    kNativeElementTypeIconImage,
    kNativeElementTypeRating,
    kNativeElementTypeLikes,
    kNativeElementTypeDownloads,
    kNativeElementTypePrice,
    kNativeElementTypeSalePrice,
    kNativeElementTypePhoneNumber,
    kNativeElementTypeStreetAddress,
    kNativeElementTypeSecondaryDescription,
    kNativeElementTypeWebsiteUrl,
    kNativeElementTypeCallToAction
};

@protocol ASNativeAdDelegate;
@protocol ASNativeAdViewElements;
@protocol ASNativeAdCustomDelegate;

@interface ASNativeAdView : UIView

/*
 * delegate, conforms to the ASNativeAdDelegate protocol
 *
 * Callback events from the native ad will be passed to the conforming class.
 */
@property (nonatomic, weak) _Nullable id<ASNativeAdDelegate> delegate;

/*
 * viewDelegate, conforms to the ASNativeAdViewElements protocol
 *
 * Callbacks to link IBOutlet UI elements to the native ad view.
 */
@property (nonatomic, weak) _Nullable id<ASNativeAdViewElements> viewDelegate;

/*
 * customDelegate, conforms to the ASNativeAdCustomDelegate protocol
 *
 * Callbacks to return raw values for native assets.
 */
@property (nonatomic, weak) _Nullable id<ASNativeAdCustomDelegate> customDelegate;

/*
 * placementId
 *
 * Read-only string that returns the placement id associated with the native ad view object
 */
@property (readonly, nonatomic, strong) NSString* _Nullable placementId;

/*
 * isPreload
 *
 * When set to YES, ads will attempt to preload when loadAd is called, and will notify of preload
 * ready through the ASNativeAdDelegate
 */
@property (nonatomic, assign) BOOL isPreload;

/*
 * useHeaderBidding
 *
 * When set to YES the requested ad will utilize header bidding to preload an ad when loadAd is called
 */
@property (nonatomic, assign) BOOL useHeaderBidding;

/*
 * locationServicesEnabled
 *
 * When set to YES to will inovke a location services authorization request
 * if the location services authorization is undetermined. Defaults to NO.
 */
@property (nonatomic, assign) BOOL locationServicesEnabled;

/*
 * hasVideoAsset
 *
 * After a loadAd is initiated, this boolean flag will be set to YES if there is a video asset
 */
@property (nonatomic, assign) BOOL hasVideoAsset;

/*
 * keywords
 *
 * An optional array of strings that will be passed along with the ad request to receive
 * more relevant advertising.
 */
@property (nonatomic, strong)  NSArray* _Nullable keywords __deprecated_msg("keywords have been deprecated, please use publisher keys (pubKeys) instead.");

/*
 * pubKeys
 *
 * An optional dictionary with publisher defined key-value pairs for more granular reporting.
 */
@property (nonatomic, strong) NSDictionary* _Nullable pubKeys;

/*
 * env
 *
 * An ENUM type used to specify the ad sesrver environment to test getting ads on.
 * This property should be left on. Mostly used for testing. Defaults to production environment.
 */
@property (nonatomic, assign) ASEnvironmentType env;

/*
 * platform
 *
 * An ENUM type used to specify the platform used for the SDK. Internally used for measurement.
 * Has no affect on requesting and serving ads. Defaults to core SDK.
 */
@property (nonatomic, assign) ASPlatformType platform;

/*
 * -configurePlacement:andDelegate:
 *
 * Input parameters:
 *     - plcId, a NSString value of the placement ID setup on the AerServ Dashboard
 *     - delegate, a class conforming to the protocol ASNativeAdDelegate, where callback events
 *       will be sent to
 *
 * Configures the native ad with the according placement ID and a delegate to callback events to.
 * This method must be called with valid parameters prior to any ad load.
 */
- (void)configurePlacement:(NSString* _Nonnull)plcId andDelegate:(id<ASNativeAdDelegate> _Nonnull)delegate;

/*
 * -loadAd
 *
 * Initiates a request for native ad, for the configured placement id.
 * Callback events for the native ad will be returned with the protocol, ASNativeAdDelelgate
 */
- (void)loadAd;

/*
 * -showAd
 *
 * Displays preloaded native ads after receiving the did preload callback event
 */
- (void)showAd;

/*
 * -playAd
 *
 * Starts video playback for native video ads
 */
- (void)playAd;

/*
 * -pauseAd
 *
 * Pauses video playback for native video ads
 */
- (void)pauseAd;

/*
 * -resumeAd
 *
 * Rssumes video playback for native video ads
 */
- (void)resumeAd;

/*
 * -cancel
 *
 * Stops loading, removes, and cleans up the native ad
 */
- (void)cancel;

/*
 * -refreshAssets
 *
 * When a view is resized due to autolayout, there could be an asset associated
 * with the native ad that fits the resized layout better. Call this method to check
 * for such an asset.
 */
- (void)refreshAssets;

#pragma mark - Custon Native Methods

/*
 * -fireImpressionEvent
 *
 * For custom native ads, call this method when you have displayed the native ad
 * to log the impression event to AerServ servers
 */
- (void)fireImpressionEvent;

/*
 * -fireClickEventForElement:
 *
 * Input Parameters:
 *     - type, an ASNativeElementType ENUM that specifies which native element
 *
 * Fires click event for the asset element type passed in.
 * Works for all element types except for Video.
 * Click events for Video are contained in the VAST tag returned.
 */
- (void)fireClickEventForElement:(ASNativeElementType)type;

/*
 * -linkeForElement:
 *
 * Input Parameters:
 *     - type, an ASNativeElementType
 *
 * Returns click through links for each of the asset element types.
 *
 * Works for all element types except for Video.
 * Click through URLs for Video are contained in the VAST tag returned.
 */
- (NSURL* _Nullable)linkForElement:(ASNativeElementType)type;

/*
 * -loadImageWithUrl:
 *
 * Input Parameters:
 *     - urlStr, an NSString of the image url
 *
 * Returns an image for the given input url.
 *
 * Added as a helper method for supporting MoPub Native Plugin.
 */
- (UIImage* _Nullable)loadImageWithUrl:(NSString* _Nullable)urlStr;

@end

/*
 * ASNativeAdDelegate Protocol
 *
 * Protocol used to convey events from the native ad view object.
 */
@protocol ASNativeAdDelegate <NSObject>
@optional

/*
 * -nativeAd:didFailToLoadWithError:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *     - error, NSError object that gives reason for ad failure
 *
 * Implement this callback to receive information when an ad fails.
 */
- (void)nativeAd:(ASNativeAdView* _Nullable)nativeAdView didFailToLoadWithError:(NSError* _Nullable)error;

/*
 * - nativeAdDidLoad:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified with a native ad successfully loads.
 */
- (void)nativeAdDidLoad:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdDidPreload:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified with a native ad successfully preloads. After this event,
 * call showAd on the native ad view object to display the native ad.
 */
- (void)nativeAdDidPreload:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdImpression:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified when an ad impression event is sent.
 */
- (void)nativeAdImpression:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdDidClick:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified when click event is received.
 */
- (void)nativeAdDidClick:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - viewControllerForPresentingNativeAdView:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Should return the view controller which the native ad will be displayed through.
 *
 * If native video ads will be returned, the video object needs reference to parent view controller
 * for better video playback.
 */
- (UIViewController* _Nonnull)viewControllerForPresentingNativeAdView:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdDidExpandToInterstitial:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified when native ad expands to fullscreen interstitial.
 */
- (void)nativeAdDidExpandToInterstitial:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdDidDismissInterstitial:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement this callback to be notified when native ad dismisses the fullscreen interstitial.
 */
- (void)nativeAdDidDismissInterstitial:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAdVideoDidStart:
 * - nativeAdVideoDidComplete:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Implement these callbacks to be notified when the native ad video starts or completes.
 */
- (void)nativeAdVideoDidStart:(ASNativeAdView* _Nullable)nativeAdView;
- (void)nativeAdVideoDidComplete:(ASNativeAdView* _Nullable)nativeAdView;

/*
 * - nativeAd:didLoadWithTransactionInfo:
 * - nativeAd:didShowWithTransactionInfo:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * When a native ad is loaded or shown, transaction info regarding the choosen ad will be returned
 * through these callbacks.
 */
- (void)nativeAd:(ASNativeAdView* _Nullable)nativeAdView didLoadWithTransactionInfo:(NSDictionary* _Nonnull)transactionInfo;
- (void)nativeAd:(ASNativeAdView* _Nullable)nativeAdView didShowWithTransactionInfo:(NSDictionary* _Nonnull)transactionInfo;

/*
 * - nativeAd:didFireAdvertiserEventWithMessages:
 *
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *     - msg, a string describing the advertiser event fired
 *
 * This callback is internally used for testing. Should not be implmeneted as messages
 * are viable to be changed without notice.
 */
- (void)nativeAd:(ASNativeAdView* _Nullable)nativeAdView didFireAdvertiserEventWithMessage:(NSString* _Nonnull)msg;

@end

/*
 * ASNativeAdViewElements Protocol
 *
 * Protocol used to link IBOutlet elements connected to a NIB file to the native ad view object.
 *
 */
@protocol ASNativeAdViewElements <NSObject>
@optional

/*
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *
 * Should return the IBOutlet UILabel, UIImageView, or UIButton element that corresponds to the
 * native asset desired for that UI element in the NIB view.
 *
 * Please refer to native integration documentation for further explanation of usage.
 */
- (UILabel* _Nonnull)nativeTitleLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeSponsoredLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativePrimaryDescLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UIImageView* _Nonnull)nativeMainImgViewFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UIView* _Nonnull)nativeVideoViewFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UIImageView* _Nonnull)nativeIconImgViewFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeRatingLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeLikesLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeDownloadsLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativePriceLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeSalePriceLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativePhoneNumLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeStreetAddressLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeSecondaryDescLblFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UILabel* _Nonnull)nativeWebsiteUrlFromAdView:(ASNativeAdView* _Nonnull)nativeView;
- (UIButton* _Nonnull)nativeActionBtnFromAdView:(ASNativeAdView* _Nonnull)nativeView;

@end

/*
 * ASNativeAdCustomDelegate Protocol
 *
 * Protocol used to return data raw as strings or string URLs.
 */
@protocol ASNativeAdCustomDelegate <NSObject>
@optional

/*
 * Callback Parameters:
 *     - nativeAdView, reference to the ASNativeAdView object that the callback originated from
 *     - ____Str, a string that contains the text or text URL for the native asset
 *     - imgSize, when an image url is returned a corresponding size will be returned as well
 *
 * Please refer to native integration documentation for further explanation of usage.
 *
 * Note for image assets, the callback could be called multiple times to return images of varying
 * size
 */
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasTitle:(NSString* _Nonnull)titleStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasSponsored:(NSString* _Nonnull)sponsoredStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasPrimaryDesc:(NSString* _Nonnull)primaryDescStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasMainImgUrl:(NSString* _Nonnull)mainImgUrlStr withSize:(CGSize)imgSize;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasVastTag:(NSString* _Nonnull)vastTagStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasIconImgUrl:(NSString* _Nonnull)iconImgUrlStr withSize:(CGSize)imgSize;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasRating:(NSString* _Nonnull)ratingStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasLikes:(NSString* _Nonnull)likesStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasDownloads:(NSString* _Nonnull)downloadsStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasPrice:(NSString* _Nonnull)priceStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasSalePrice:(NSString* _Nonnull)salePriceStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasPhoneNum:(NSString* _Nonnull)phoneNumStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasStreetAddress:(NSString* _Nonnull)streetAddrStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasSecondaryDesc:(NSString* _Nonnull)secondDescStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasWebsiteUrl:(NSString* _Nonnull)websiteUrlStr;
- (void)nativeAdView:(ASNativeAdView* _Nonnull)nativeView hasCallToAction:(NSString* _Nonnull)callToActionStr;

@end

