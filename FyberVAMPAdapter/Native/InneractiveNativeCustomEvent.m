//
//  InneractiveNativeCustomEvent.m
//  IASDKClient
//
//  Created by Inneractive on 28/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "InneractiveNativeCustomEvent.h"
#import "IASDKMopubAdapterConfiguration.h"
#import "InneractiveNativeAdAdapter.h"
#import "InneractiveNativeAdRenderer.h"
#import "MPNativeAdRendererConfiguration.h"
#import "InneractiveNativeAdRendererSettings.h"

#import "MPNativeAd.h"
#import "MPNativeAdError.h"
#import "MPNativeAdRequestTargeting.h"
#import "MPLogging.h"

#import <IASDKCore/IASDKCore.h>
#import <IASDKVideo/IASDKVideo.h>
#import <IASDKNative/IASDKNative.h>

@interface InneractiveNativeCustomEvent () <IANativeUnitControllerDelegate, IANativeContentDelegate>

@property (nonatomic, strong) InneractiveNativeAdAdapter *adAdapter;
@property (nonatomic, strong) MPNativeAd *interfaceAd;

@property (nonatomic, strong) IAAdSpot *adSpot;
@property (nonatomic, strong) IANativeUnitController *adUnitController;
@property (nonatomic, strong) IANativeContentController *adContent;

@end

@implementation InneractiveNativeCustomEvent {}

static const int kInneractiveErrorNoInventory = 1;

#pragma mark - MPNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    if (info && [info isKindOfClass:NSDictionary.class] && info.count) {
		[self initAdWithInfo:info];
	} else {
		[self initAdWithInfo:nil];
	}

	[self fetchAd];
}

- (void)initAdWithInfo:(NSDictionary *)info {
    IANativeAdDescription *nativeAdDescription = [IANativeAdDescription build:^(id<IANativeAdDescriptionBuilder>  _Nonnull builder) {
        builder.assetsDescription.titleAssetPriority = IANativeAdAssetPriorityRequired;
        builder.nativeAdMainAssetMinWidth = 100;
        builder.nativeAdMainAssetMinHeight = 100;
        builder.maxBitrate = 8192;
    }];
	
	NSString *keywords = nil;
	NSString *receivedKeywords = info[@"keywords"];
        
	if (receivedKeywords && [receivedKeywords isKindOfClass:NSString.class] && receivedKeywords.length) {
		keywords = receivedKeywords;
	}
	
    // TODO: review
	//NSString *appID = kInneractiveDefaultAppID;
	//NSString *receivedAppID = info[kInneractiveSpotIDKey];
        
	//if (receivedAppID && [receivedAppID isKindOfClass:NSString.class] && receivedAppID.length) {
	//	appID = receivedAppID;
	//}
	
	CLLocation *location = nil;
	
	if ([self.delegate respondsToSelector:@selector(targeting)]) {
        MPNativeAdRequestTargeting *targeting = [self.delegate performSelector:@selector(targeting)];
        
        if (targeting && [targeting isKindOfClass:MPNativeAdRequestTargeting.class]) {
            if (targeting.location) {
                location = targeting.location;
            }
        }
    }

    IAAdRequest *request = [IAAdRequest build:^(id<IAAdRequestBuilder>  _Nonnull builder) {
        builder.useSecureConnections = NO;
		builder.spotID = @"150950"; // native video;
        builder.timeout = 20;
        builder.subtypeDescription = nativeAdDescription;
        builder.autoLocationUpdateEnabled = YES;
		builder.keywords = keywords;
		builder.location = location;
    }];
	
	
	
    _adContent = [IANativeContentController build:^(id<IANativeContentControllerBuilder>  _Nonnull builder) { builder.nativeContentDelegate = self; }];
    _adUnitController = [IANativeUnitController build:^(id<IANativeUnitControllerBuilder>  _Nonnull builder) {
        builder.unitDelegate = self;
        [builder addSupportedContentController:self.adContent];
    }];
    
    _adSpot = [IAAdSpot build:^(id<IAAdSpotBuilder>  _Nonnull builder) {
        builder.adRequest = request;
        builder.mediationType = [IAMediationMopub new];
        [builder addSupportedUnitController:self.adUnitController];
    }];
    
}

- (void)fetchAd {
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], nil);
    __weak typeof(self) weakSelf = self;
    
    [self.adSpot fetchAdWithCompletion:^(IAAdSpot * _Nullable adSpot, IAAdModel * _Nullable adModel, NSError * _Nullable error) { // 'self' should not be used in this block;

        if (error) {
			
			weakSelf.adUnitController = nil;
			
			if (error.code == kInneractiveErrorNoInventory) {
                [MPLogging logEvent:[MPLogEvent adLoadFailedForAdapter:NSStringFromClass(weakSelf.class) error:error] source:nil fromClass:weakSelf.class];
                [weakSelf.delegate nativeCustomEvent:weakSelf didFailToLoadAdWithError:MPNativeAdNSErrorForNoInventory()];
			} else {                
                [MPLogging logEvent:[MPLogEvent adLoadFailedForAdapter:NSStringFromClass(weakSelf.class) error:MPNativeAdNSErrorForInvalidAdServerResponse(@"Inneractive ad load error")] source:nil fromClass:weakSelf.class];
                [weakSelf.delegate nativeCustomEvent:weakSelf didFailToLoadAdWithError:MPNativeAdNSErrorForInvalidAdServerResponse(@"Inneractive ad load error")];
			}

        }
		else {
			__strong __typeof(weakSelf)strongSelf = weakSelf;
            
			[MPLogging logEvent:[MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(strongSelf.class)] source:nil fromClass:strongSelf.class];
            
			BOOL isVideoAd = NO;
			if ([adModel.contentModel isKindOfClass:IANativeContentModel.class]) {
				IANativeContentModel *model = (IANativeContentModel *)adModel.contentModel;
				isVideoAd = (nil != model.VASTModel);
			}

			strongSelf.adAdapter = [[InneractiveNativeAdAdapter alloc] initWithInneractiveNativeUnitController:strongSelf.adUnitController];
			strongSelf.adAdapter.isVideoAd = isVideoAd;
			strongSelf.interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:strongSelf.adAdapter];
    
			[strongSelf.delegate nativeCustomEvent:strongSelf didLoadAd:strongSelf.interfaceAd];
        }
    }];
}

#pragma mark - IANativeUnitControllerDelegate

- (UIViewController * _Nonnull)IAParentViewControllerForUnitController:(IAUnitController * _Nullable)unitController {
    // actually, will be never invoked from this class, implementing only to show the right method implementation,
    // and to prevent compiler warning, because this is required interface method;
    //
    // note: after ad fetch complition block is called, the 'InneractiveNativeAdAdapter' class instance,
    // will take the responsibility of IA ads delegate events
    return self.adAdapter.delegate.viewControllerForPresentingModalView;
}

#pragma mark - Memory management

- (void)dealloc {
    MPLogDebug(@"%@ deallocated", NSStringFromClass(self.class));
}
@end
