//
//  SOMAMoPubInterstitialAdapter.m
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 09/10/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SOMAMoPubInterstitialAdapter.h"
#import <CoreLocation/CoreLocation.h>

@implementation SOMAMoPubInterstitialAdapter

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{
	self.adview = [[SOMAInterstitialAdView alloc] init];
	self.adview.delegate = self;
	self.adview.adSettings.autoReloadEnabled = YES;
	self.adview.adSettings.autoReloadInterval = 10;
	
	if ([[info allKeys] containsObject:@"pub"]) {
		self.adview.adSettings.publisherId=[info[@"pub"] intValue];
	} else if ([[info allKeys] containsObject:@"publisher"]) {
		self.adview.adSettings.publisherId=[info[@"publisher"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherid"]) {
		self.adview.adSettings.publisherId=[info[@"publisherid"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherId"]) {
		self.adview.adSettings.publisherId=[info[@"publisherId"] intValue];
	} else if ([[info allKeys] containsObject:@"PublisherId"]) {
		self.adview.adSettings.publisherId=[info[@"PublisherId"] intValue];
	} else if ([[info allKeys] containsObject:@"PublisherID"]) {
		self.adview.adSettings.publisherId=[info[@"PublisherID"] intValue];
	} else if ([[info allKeys] containsObject:@"publisherID"]) {
		self.adview.adSettings.publisherId=[info[@"publisherID"] intValue];
	} else if ([[info allKeys] containsObject:@"Publisher"]) {
		self.adview.adSettings.publisherId=[info[@"Publisher"] intValue];
	}
	
	if ([[info allKeys] containsObject:@"ad"]) {
		self.adview.adSettings.adSpaceId=[info[@"ad"] intValue];
	} else if ([[info allKeys] containsObject:@"adspace"]) {
		self.adview.adSettings.adSpaceId=[info[@"adspace"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceid"]) {
		self.adview.adSettings.adSpaceId=[info[@"adspaceid"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceId"]) {
		self.adview.adSettings.adSpaceId=[info[@"adspaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdspaceId"]) {
		self.adview.adSettings.adSpaceId=[info[@"AdspaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdspaceID"]) {
		self.adview.adSettings.adSpaceId=[info[@"AdspaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"adspaceID"]) {
		self.adview.adSettings.adSpaceId=[info[@"adspaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpaceID"]) {
		self.adview.adSettings.adSpaceId=[info[@"AdSpaceID"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpaceId"]) {
		self.adview.adSettings.adSpaceId=[info[@"AdSpaceId"] intValue];
	} else if ([[info allKeys] containsObject:@"AdSpace"]) {
		self.adview.adSettings.adSpaceId=[info[@"AdSpace"] intValue];
	} else if ([[info allKeys] containsObject:@"Ad"]) {
		self.adview.adSettings.adSpaceId=[info[@"Ad"] intValue];
	}
	
	CLLocation* location =  [self.delegate location];
	if (location) {
		self.adview.adSettings.longitude = location.coordinate.longitude;
		self.adview.adSettings.latitude = location.coordinate.latitude;
	}
	
	
	// UPDATE LOCATION
	//self.somaBanner.adSettings.longitude = LONGITUDE;
	//self.somaBanner.adSettings.latitude = LATITUDE;
	
	/*************************************
	 Set user targetting parameters
	 *************************************/
	// UNCOMMENT THE FOLLOWING LINE FIRST
//		SOMAUserProfile* profile = self.adview.adSettings.userProfile;
	
	/*
	 Set age
	 */
	//	 profile.age = 30; // integer value
	
	/*
	 Set Gender: Possible values:
	 ----------------------------
	 SOMAUserGenderUnknown,
	 SOMAUserGenderMale,
	 SOMAUserGenderFemale
	 */
	//	 profile.gender = SOMAUserGenderMale;
	
	/*
	 Set Date of Birth: NSString
	 ----------------------------
	 Date with YYYYMMDD format e.g. @"19550224" for February 24, 1955
	 */
	//	 profile.dateOfBirthYYYYMMDD = @"19550224";
	
	/*
	 Set Yearly income: Possible values:
	 ----------------------------
	 SOMAUserYearlyIncomeUnknown,
	 SOMAUserYearlyIncomeLessThan15K,
	 SOMAUserYearlyIncome15to24K,
	 SOMAUserYearlyIncome25to39K,
	 SOMAUserYearlyIncome40to59K,
	 SOMAUserYearlyIncome60to74K,
	 SOMAUserYearlyIncome75to99K,
	 SOMAUserYearlyIncome100kPlus
	 */
	//	 profile.yearlyIncome = SOMAUserYearlyIncome100kPlus;
	
	/*
	 Set ethnicity: Possible values:
	 ----------------------------
	 SOMAUserEthnicityUnknown,
	 SOMAUserEthnicityWhite,
	 SOMAUserEthnicityMiddleEastern,
	 SOMAUserEthnicityBlack,
	 SOMAUserEthnicityLatino,
	 SOMAUserEthnicitySouthAsian,
	 SOMAUserEthnicityOriental,
	 SOMAUserEthnicityOther
	 */
	//	profile.ethnicity = SOMAUserEthnicityBlack;
	
	/*
	 Set education: Possible values:
	 ----------------------------
	 SOMAUserEducationUnknown=0,
	 SOMAUserEducationLessThanSecondary,
	 SOMAUserEducationSecondary,
	 SOMAUserEducationUniversity,
	 SOMAUserEducationAdvanced
	 */
	//	profile.education = SOMAUserEducationAdvanced;
	
	/*
	 Set interest: Possible values:
	 ----------------------------
	 SOMAUserGenderInterestUnknown = 0,
	 SOMAUserGenderInterestBoth,
	 SOMAUserGenderInterestMale,
	 SOMAUserGenderInterestFemale
	 */
	//	profile.interestedIn = SOMAUserGenderInterestBoth;
	
	/*
	 Set marital status: Possible values:
	 ----------------------------
	 SOMAUserMaritalStatusUnknown=0,
	 SOMAUserMaritalStatusSingle,
	 SOMAUserMaritalStatusMarried,
	 SOMAUserMaritalStatusDivorced
	 */
	//	profile.maritalStatus = SOMAUserMaritalStatusMarried;
	
	/*
	 Set country: Any String value.
	 */
	//	profile.country = @"Country";
	
	/*
	 Set country code: Any String value.
	 */
	//	profile.countryCode = @"countryCode";
	
	/*
	 Set region: Any String value.
	 */
	//	profile.region = @"region";
	
	/*
	 Set City: Any String value.
	 */
	//	profile.city = @"city";
	
	/*
	 Set zip code: Any String value.
	 */
	//	profile.zip = @"zip";
	
	////////// END TARGETTING ////////////////////////
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.adview load];
        
    });
	
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
	[self.adview show:rootViewController];
}
- (BOOL)enableAutomaticImpressionAndClickTracking{
	// Subclasses may override this method to return NO to perform impression and click tracking
	// manually.
	return YES;
}

#pragma mark -
#pragma mark - SOMAAdviewDelegate
#pragma mark -
- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
        [self.delegate interstitialCustomEvent:self didLoadAd:nil];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void)somaAdViewDidClick:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidReceiveTapEvent:)]) {
        [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    }
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventWillAppear:)]) {
        [self.delegate interstitialCustomEventWillAppear:self];
    }
}

- (void)somaAdViewDidEnterFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidAppear:)]) {
        [self.delegate interstitialCustomEventDidAppear:self];
    }
}
- (void)somaAdViewWillExitFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventWillDisappear:)]) {
        [self.delegate interstitialCustomEventWillDisappear:self];
    }
}
- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
    [self.adview removeFromSuperview];
    self.adview.delegate = nil;
    self.adview = nil;
}

- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview{

}

- (void)somaAdViewWillLeaveApplicationFromAd:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventWillLeaveApplication:)]) {
        [self.delegate interstitialCustomEventWillLeaveApplication:self];
    }
}


@end
