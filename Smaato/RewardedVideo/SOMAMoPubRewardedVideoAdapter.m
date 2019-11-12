//
//  SOMAMoPubRewardedVideoAdapter.m
//  iSoma
//
//  Created by Aman Shaikh on 22.05.17.
//  Copyright © 2017 Smaato Inc. All rights reserved.
//

#import "SOMAMoPubRewardedVideoAdapter.h"
#import <iSoma/iSoma.h>

@interface SOMAMoPubRewardedVideoAdapter()<SOMAVideoAdControllerDelegate>
@property SOMAVideoAdController* videoAdController;
@property MPRewardedVideoReward *defaultReward;
@end

@implementation SOMAMoPubRewardedVideoAdapter
- (void) requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    self.defaultReward = [[MPRewardedVideoReward alloc]
                          initWithCurrencyType:kMPRewardedVideoRewardCurrencyTypeUnspecified
                          amount:[[NSNumber alloc] initWithInt:1]];
    
	self.videoAdController = [[SOMAVideoAdController alloc] init];
	self.videoAdController.delegate = self;
	
//	self.adview.adSettings.httpsOnly = NO;
	
	[self updateSettingsFromInfo:info];
		
	[self.videoAdController loadRewardedVideo];
}

- (BOOL)hasAdAvailable {
	return [self.videoAdController isReady];
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController{
	if ([self.videoAdController isReady]) {
		[self.videoAdController show:viewController];
	}
}

- (BOOL)enableAutomaticImpressionAndClickTracking{
	// Subclasses may override this method to return NO to perform impression and click tracking
	// manually.
	return YES;
}

- (void)handleAdPlayedForCustomEventNetwork{
	// The default implementation of this method does nothing. Subclasses must override this method
	// and implement code to handle when another ad unit plays an ad for the same ad network this custom event is representing.
}

- (void)handleCustomEventInvalidated{
	// The default implementation of this method does nothing. Subclasses must override this method
	// and implement code to handle when the custom event is no longer needed by the rewarded video system.
}

#pragma mark - Utility
#pragma mark -

- (void) updateSettingsFromInfo:(NSDictionary*) info{
	self.videoAdController.adSettings.publisherId = (nil != info[@"pub"]) ? [info[@"pub"] intValue] : [info[@"publisher"] intValue];
	self.videoAdController.adSettings.adSpaceId = (nil != info[@"ad"]) ? [info[@"ad"] intValue] : [info[@"adspace"] intValue];
	
	if ([[info allKeys] containsObject:@"pub"]) {
		self.videoAdController.adSettings.publisherId=[info[@"pub"] intValue];
	} else if ([[info allKeys] containsObject:@"publisher"]) {
		self.videoAdController.adSettings.publisherId=[info[@"publisher"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherid"]) {
		self.videoAdController.adSettings.publisherId=[info[@"publisherid"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherId"]) {
		self.videoAdController.adSettings.publisherId=[info[@"publisherId"] intValue];
	} else if ([[info allKeys] containsObject:@"PublisherId"]) {
		self.videoAdController.adSettings.publisherId=[info[@"PublisherId"] intValue];
	} else if ([[info allKeys] containsObject:@"PublisherID"]) {
		self.videoAdController.adSettings.publisherId=[info[@"PublisherID"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherID"]) {
		self.videoAdController.adSettings.publisherId=[info[@"publisherID"] intValue];
	} else if ([[info allKeys] containsObject:@"Publisher"]) {
		self.videoAdController.adSettings.publisherId=[info[@"Publisher"] intValue];
	}
	
	if ([[info allKeys] containsObject:@"ad"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"ad"] intValue];
	} else if ([[info allKeys] containsObject:@"adspace"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"adspace"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceid"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"adspaceid"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceId"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"adspaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdspaceId"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"AdspaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdspaceID"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"AdspaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceID"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"adspaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpaceID"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"AdSpaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpaceId"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"AdSpaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpace"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"AdSpace"] intValue];
	} else if ([[info allKeys] containsObject:@"Ad"]) {
		self.videoAdController.adSettings.adSpaceId=[info[@"Ad"] intValue];
	}
}

#pragma mark - SOMAVideoAdControllerDelegate
#pragma mark -
- (void)somaVideoAdDidLoadAd:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidLoadAdForCustomEvent:)]) {
        [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
    }
}

- (void)somaVideoAd:(SOMAVideoAdController*) adview didFailToReceiveAdWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidFailToLoadAdForCustomEvent:error:)]) {
        [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    }
}

- (void)somaAdViewDidClick:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidReceiveTapEventForCustomEvent:)]) {
        [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    }
}

- (void)somaVideoAd:(SOMAVideoAdController*) adview isClosed:(BOOL)userClickedCloseButton{
}

- (void)somaVideoAdWillLoadAd:(SOMAVideoAdController *)adview{
}

- (void)somaVideoAdWillEnterFullscreen:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoWillAppearForCustomEvent:)]) {
        [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    }
}

- (void)somaVideoAdDidEnterFullscreen:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidAppearForCustomEvent:)]) {
        [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    }
	
}

//- (void)somaVideoAdWillHide:(SOMAVideoAdController*)adview{
//    if ([self.delegate respondsToSelector:@selector(rewardedVideoWillDisappearForCustomEvent:)]) {
//        [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
//    }
//}

- (void)somaVideoAdWillExitFullscreen:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoWillDisappearForCustomEvent:)]) {
        [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    }
}

- (void)somaVideoAdDidExitFullscreen:(SOMAVideoAdController *)adview{
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidDisappearForCustomEvent:)]) {
        [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
    }
}

- (void)somaVideoAdApplicationWillGoBackground:(SOMAVideoAdController *)adview{
	
}

-(void)somaVideoAdWillLeaveApplicationFromAd:(SOMAVideoAdController *)adview {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoWillLeaveApplicationForCustomEvent:)]) {
        [self.delegate rewardedVideoWillLeaveApplicationForCustomEvent:self];
    }
}

- (void)somaVideoAd:(SOMAVideoAdController *)adview didReceiveVideoAdEvent:(SOMAVideoAdTrackingEvent)event{
	if (event == SOMAVideoAdTrackingEventComplete) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoShouldRewardUserForCustomEvent:reward:)]) {
            [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:self.defaultReward];
        }
	}
}

- (void)somaVideoAd:(SOMAVideoAdController *)adview didReceiveVideoAdEvent:(SOMAVideoAdTrackingEvent)event withURLCount:(NSUInteger)count{
}

@end
