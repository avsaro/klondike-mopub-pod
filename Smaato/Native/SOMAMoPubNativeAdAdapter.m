//
//  SOMAMoPubNativeAdAdapter.m
//  iSoma
//
//  Created by Aman Shaikh on 14.07.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SOMAMoPubNativeAdAdapter.h"
#import "MPLogging.h"
#import <iSoma/iSoma.h>
#import "MPNativeAdConstants.h"

@interface SOMAMoPubNativeAdAdapter()
@property SOMABeaconCallingAgent* agent;
@end

@implementation SOMAMoPubNativeAdAdapter

- (instancetype)init:(NSDictionary*)properties withDefaultActionURL:(NSURL*)url{
	self = [super init];
	if (self) {
		_properties = properties;
		_defaultActionURL =  url;
	}
	return self;
}
-(void)dealloc {
    if (self.agent) {
        self.agent = nil;
    }
}
- (BOOL)enableThirdPartyClickTracking{
	return NO;
}

- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller{
	if ([self.delegate respondsToSelector:@selector(nativeAdWillLeaveApplicationFromAdapter:)]){
		[self.delegate nativeAdWillLeaveApplicationFromAdapter:self];
	}
	
	if ([self.delegate respondsToSelector:@selector(nativeAdDidClick:)]) {
		[self.delegate nativeAdDidClick:self];
	}
    if (!self.isClickTrackersCalled) {
        NSArray* urls =  _properties[kClickTrackerURLKey];
        if (urls != nil && [urls isKindOfClass:[NSArray class]]) {
            [[SOMABeaconCallingAgent alloc] initWithURL:urls forAdObject:nil withSettings:nil callback:^(SOMABeaconCallingAgent *agent) {
                self.isClickTrackersCalled = YES;
                agent = nil;
            }];
        }
    }
    
	[[UIApplication sharedApplication] openURL:URL];
}


- (UIView*)createSponsoredInfoView{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 60, 8)];
	label.text = @"Sponsored";
	label.textAlignment = NSTextAlignmentCenter;
	label.minimumScaleFactor = 0.1;
	label.adjustsFontSizeToFitWidth = YES;
	label.font = [UIFont systemFontOfSize:6];
	label.clipsToBounds = YES;
	label.tag = 623863;
	label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
	label.textColor = [UIColor colorWithWhite:1 alpha:0.7];
	return label;
}

- (void)willAttachToView:(UIView *)view{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		self.sponsoredInfoView = [self createSponsoredInfoView];
		CGRect sponsoredViewRect = self.sponsoredInfoView.frame;
		sponsoredViewRect.origin.x = view.bounds.size.width - sponsoredViewRect.size.width;
		self.sponsoredInfoView.frame = sponsoredViewRect;
		
		[view addSubview:self.sponsoredInfoView];				
		[view bringSubviewToFront:self.sponsoredInfoView];
	});
	
	
	if ([self.delegate respondsToSelector:@selector(nativeAdWillLogImpression:)]) {
		[self.delegate nativeAdWillLogImpression:self];
		if (self.isBeaconsCalled == NO) {
			self.isBeaconsCalled = YES;
			NSArray* urls =  _properties[kImpressionTrackerURLsKey];
			if (urls != nil && [urls isKindOfClass:[NSArray class]]) {
                if (self.agent) {
                    self.agent = nil;
                }
                self.agent = [[SOMABeaconCallingAgent alloc] initWithURL:urls forAdObject:nil withSettings:nil callback:^(SOMABeaconCallingAgent *agent) {
                }];
			}
		}
	} else {
		MPLogWarn(@"Delegate does not implement impression tracking callback. Impressions likely not being tracked.");
	}
}

@end
