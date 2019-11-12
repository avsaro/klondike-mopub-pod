//
//  InneractiveNativeAdAdapter.m
//  IASDKClient
//
//  Created by Inneractive on 30/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "InneractiveNativeAdAdapter.h"
#import "MPLogging.h"

#import <IASDKCore/IASDKCore.h>
#import <IASDKVideo/IASDKVideo.h>
#import <IASDKNative/IASDKNative.h>

@interface InneractiveNativeAdAdapter () <IANativeUnitControllerDelegate, IANativeContentDelegate>

@end

@implementation InneractiveNativeAdAdapter {}

@synthesize properties = _properties;

#pragma mark - Init

- (instancetype)initWithInneractiveNativeUnitController:(IANativeUnitController *)nativeUnitController {
    self = [super init];
    
    if (self) {
        nativeUnitController.unitDelegate = self;
		_nativeUnitController = nativeUnitController;
    }
    
    return self;
}

#pragma mark - MPNativeAdAdapter

- (NSURL *)defaultActionURL {
    return nil;
}

- (UIView *)mainMediaView {
	return _mainMediaView;
}

- (BOOL)enableThirdPartyClickTracking {
    return YES;
}

#pragma mark - IANativeUnitControllerDelegate

- (UIViewController * _Nonnull)IAParentViewControllerForUnitController:(IAUnitController * _Nullable)unitController {
	UIViewController *viewController = [self.delegate viewControllerForPresentingModalView];
 
    return viewController;
}

- (void)IAAdDidReceiveClick:(IAUnitController * _Nullable)unitController {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], nil);
    [self.delegate nativeAdDidClick:self];
}

- (void)IAAdWillLogImpression:(IAUnitController * _Nullable)unitController {
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], nil);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], nil);
    [self.delegate nativeAdWillLogImpression:self];
}

- (void)IAUnitControllerWillPresentFullscreen:(IAUnitController * _Nullable)unitController {
    MPLogAdEvent([MPLogEvent adWillPresentModalForAdapter:NSStringFromClass(self.class)], nil);
    [self.delegate nativeAdWillPresentModalForAdapter:self];
}

- (void)IAUnitControllerDidPresentFullscreen:(IAUnitController * _Nullable)unitController {
	// no corresponding method in self.delegate
    MPLogInfo(@"IAUnitControllerDidPresentFullscreen");
}

- (void)IAUnitControllerWillDismissFullscreen:(IAUnitController * _Nullable)unitController {
	// no corresponding method in self.delegate
    MPLogInfo(@"IAUnitControllerWillDismissFullscreen");
}

- (void)IAUnitControllerDidDismissFullscreen:(IAUnitController * _Nullable)unitController {
    MPLogAdEvent([MPLogEvent adDidDismissModalForAdapter:NSStringFromClass(self.class)], nil);
    [self.delegate nativeAdDidDismissModalForAdapter:self];
}

- (void)IAUnitControllerWillOpenExternalApp:(IAUnitController * _Nullable)unitController {
    MPLogAdEvent([MPLogEvent adWillLeaveApplicationForAdapter:NSStringFromClass(self.class)], nil);
    [self.delegate nativeAdWillLeaveApplicationFromAdapter:self];
}

- (void)IAAdDidRefresh:(IAUnitController * _Nullable)unitController {
	// no corresponding method in self.delegate
    MPLogInfo(@"IAAdDidRefresh");
}

#pragma mark - IAVideoContentDelegate

- (void)IAVideoCompleted:(IAVideoContentController * _Nullable)contentController {
    MPLogInfo(@"IAVideoCompleted");
}

- (void)IAVideoContentController:(IAVideoContentController * _Nullable)contentController videoInterruptedWithError:(NSError * _Nonnull)error {
    MPLogInfo(@"videoInterruptedWithError");
}

- (void)IAVideoContentController:(IAVideoContentController * _Nullable)contentController videoDurationUpdated:(NSTimeInterval)videoDuration {
    MPLogInfo(@"videoDurationUpdated");
}

- (void)IAVideoContentController:(IAVideoContentController * _Nullable)contentController videoProgressUpdatedWithCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    MPLogInfo(@"videoProgressUpdatedWithCurrentTime");
}

#pragma mark - Memory management

- (void)dealloc {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], nil);
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], nil);
    MPLogDebug(@"%@ deallocated", NSStringFromClass(self.class));
}

@end
