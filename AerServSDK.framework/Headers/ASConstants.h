//
//  kAerServConstants.h
//  AerServSDK
//
//  Created by Albert Zhu on 6/5/15.
//  Copyright (c) 2015 AerServ, LLC. All rights reserved.
//

#ifndef AerServSDK_AerServConstants_h
#define AerServSDK_AerServConstants_h

#pragma mark - Debug Flags

#define kCommShowDebug 0
#define kCommShowData 0
#define kCommShowEventsDebug 0
#define kConfigShowDebug 0
#define kShowManagerAdsInfo 0
#define kAlertManagerShowDebug 0

#pragma mark - AerServ Constants

#define kAerServNetworkName @"AerServ"
#define kAerServSDKName @"AerServ-iOS-SDK"
#define kAerServSDKVersion @"3.1.7"

#define kOpenAuctionMockData 0
#define kASBudgetTargetURLPath @"as/adapter/v1/"
#define kASBaseURLPath @"as/sdk/v3/"

#define kASProductionBaseURL @"https://ads.aerserv.com/"
#define kASStagingBaseURL @"https://staging-ads.aerserv.com/"
#define kASDevBaseURL @"https://dev-ads.aerserv.com/"

#pragma mark - Block Typedef Constants

typedef void (^ASCompletionBlock)(void);
typedef void (^ASSuccessBlock)(BOOL success);
typedef void (^ASErrorCompletionBlock)(NSError* err);
typedef void (^ASRequestCompletionBlock)(NSURLResponse* resp, NSData* data, NSError* err);
typedef void (^ASDataCompletionBlock)(NSData* data);

#pragma mark - Enum Constants

typedef NS_ENUM(NSUInteger, ASLoadType) {
    kASLoadTypeRegular = 0,
    kASLoadTypePreload = 1,
    kASLoadTypePrecache = 2,
    kASLoadTypeHeaderBidding = 3,
    kASLoadTypeBannerRefresh = 4
};

typedef NS_ENUM(NSUInteger, ASEnvironmentType) {
    kASEnvProduction,
    kASEnvStaging,
    kASEnvDevelopment
};

typedef NS_ENUM(NSUInteger, ASEndpointType) {
    kASEndPointBudgetingTargeting,
    kASEndPointWaterFall
};

typedef NS_ENUM(NSUInteger, ASPlatformType) {
    kASPlatformCS = 0,
    kASPlatformU,
    kASPlatformPG,
    kASPlatformB4A,
    kASPlatformAA,
    kASPlatformE
};

typedef NS_ENUM(NSInteger, ASNativeAssetImageType) {
    kNativeImageTypeIcon = 1,
    kNativeImageTypeMain = 3
};

typedef NS_ENUM(NSInteger, ASNativeAssetDataType) {
    kNativeDataTypeSponsored = 1,
    kNativeDataTypeDesc = 2,
    kNativeDataTypeRating = 3,
    kNativeDataTypeLikes = 4,
    kNativeDataTypeDownloads = 5,
    kNativeDataTypePrice = 6,
    kNativeDataTypeSalePrice = 7,
    kNativeDataTypePhoneNum = 8,
    kNativeDataTypeStAddress = 9,
    kNativeDataTypeDesc2 = 10,
    kNativeDataTypeWebsiteURL = 11,
    kNativeDataTypeCTAText = 12
};

typedef NS_ENUM(NSInteger, ASAppState) {
    kASAppStateForegroud = 1,
    kASAppStateBackground = 2
};

typedef NS_ENUM(NSUInteger, ASProviderSetupState) {
    kASProviderSetupNone,
    kASProviderSetupStarted,
    kASProviderSetupReady
};

typedef NS_ENUM(NSInteger, ASMediationType) {
    kMediationSingleInstance = 1,
    kMediationFinite = 2,
    kMediationInfinite = 3
};

typedef NS_ENUM(NSInteger, ASMediationStatus) {
    kMediationStatusNone = -1,
    kMediationStatusReserved = 0,
    kMediationStatusCached = 1,
    kMediationStatusFailed = 2,
    kMediationStatusLoading = 3,
    kMediationStatusRefreshReserved = 4
};

typedef NS_ENUM(NSInteger, ASOpenAuctionStep) {
    kOpenAuctionStepPreInit = 0,
    kOpenAuctionStepBudgetingTargeting = 1,
    kOpenAuctionStepMediationLoad = 2,
    kOpenAuctionStepWaterfall = 3,
    kOpenAuctionStepShowAd = 4
};

#pragma mark - Constants

#define kTrueStr @"true"
#define kEmptyStr @""
#define kMillisInSec 1000.0f

#define kEventsAerServDomain @".aerserv.com/as/ev/"
#define kVideoStartEventStr @"ev=2"
#define kBPFEventStr @"ev=22"

// HTML STATUS CODE
//extern NSInteger const kHTTPStatusCodeOK;
//NSInteger const kHTTPStatusCodeOK = 200;
#define kHTTPStatusCodeOK 200
#define kHTTPRequestTimeOutErrorCode -1001

#pragma mark - WebKit Message Handlers

#define kDocuementDimensionsCallback @"documentDimensionsCallback"
#define kDocumentInnerHTMLCallback @"documentInnerHTMLCallback"
#define kVPAIDBridgeCallback @"vpaidBridgeCallback"
#define kVPAIDBridgeGetterCallback @"vpaidBridgeGetterCallback"

#pragma mark - Error Messages

#define kNoAdAvailable @"No ad available for this request."

#pragma mark - Macros

#define kIS_iOS_7_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define kIS_iOS_8_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define kIS_iOS_9_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
#define kIS_iOS_10_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define kIS_iOS_11_OR_LATER @available(iOS 11, *)

#define kIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kIS_PORTRAIT [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height > [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.width
#define kIS_LANDSCAPE [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.width > [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height

#define kIS_MAINTHREAD NSLog(@"-- Is Main Thread: %d", [[NSThread currentThread] isMainThread]);
#define kDisplaySelf NSLog(@"----- %@", self);

#pragma mark - Logging Macros

#define DLog(FORMAT, ...) NSDateFormatter* format=[NSDateFormatter new]; format.locale=[NSLocale currentLocale]; format.dateFormat=@"yyyy.MM.dd HH:mm:ss.SSS"; NSArray* threadArr=[[NSString stringWithFormat:@"%@", [NSThread currentThread]] componentsSeparatedByString:@" "]; NSString* threadNumStr=[threadArr[3] substringToIndex:[threadArr[3] length]-1]; NSInteger threadNum=[threadNumStr integerValue]; printf("AerServ-iOS-SDK | %s | %s | %s\n", [[NSString stringWithFormat:@"%@", [format stringFromDate:[NSDate date]]] UTF8String], [[NSString stringWithFormat:@"%d", (int)(threadNum+1000)] UTF8String], [[NSString stringWithFormat:FORMAT, __VA_ARGS__] UTF8String]); format=nil; threadArr=nil; threadNumStr=nil;

#pragma mark - Generic Javascript Queries

#define kJSGetDocumentWidth @"docuemt.width"
#define kJSGetDocumentHeight @"document.height"
#define kJSGetDocumentScrollWidth @"document.documentElement.scrollWidth"
#define kJSGetDocumentScrollHeight @"document.documentElement.scrollHeight"

#pragma mark - Lock Orientation

#define kLockOrientationPortrait @"portrait"
#define kLockOrientationLandscape @"landscape"

#endif
