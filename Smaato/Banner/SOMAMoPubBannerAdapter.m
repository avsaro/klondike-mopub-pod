//
//  SOMAMoPubBannerAdapter.m
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 02/09/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "MPAdView.h"
#import "SOMAMoPubBannerAdapter.h"

@implementation SOMAMoPubBannerAdapter
- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info{
	
	self.somaBanner = [[SOMAAdView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	self.somaBanner.delegate = self;
	
	// change the key name as you've entered on MoPub dashboard
	self.somaBanner.adSettings.publisherId=[info[@"publisher"] intValue];
	self.somaBanner.adSettings.adSpaceId = [info[@"adspace"] intValue];
	
    
    if ([[info allKeys] containsObject:@"pub"]) {
        self.somaBanner.adSettings.publisherId=[info[@"pub"] intValue];
    } else if ([[info allKeys] containsObject:@"publisher"]) {
        self.somaBanner.adSettings.publisherId=[info[@"publisher"] intValue];
    } else if ([[info allKeys] containsObject:@"publisherid"]) {
        self.somaBanner.adSettings.publisherId=[info[@"publisherid"] intValue];
    } else if ([[info allKeys] containsObject:@"publisherId"]) {
        self.somaBanner.adSettings.publisherId=[info[@"publisherId"] intValue];
    } else if ([[info allKeys] containsObject:@"PublisherId"]) {
        self.somaBanner.adSettings.publisherId=[info[@"PublisherId"] intValue];
    } else if ([[info allKeys] containsObject:@"PublisherID"]) {
        self.somaBanner.adSettings.publisherId=[info[@"PublisherID"] intValue];
    } else if ([[info allKeys] containsObject:@"publisherID"]) {
        self.somaBanner.adSettings.publisherId=[info[@"publisherID"] intValue];
    } else if ([[info allKeys] containsObject:@"Publisher"]) {
        self.somaBanner.adSettings.publisherId=[info[@"Publisher"] intValue];
    }
    
    if ([[info allKeys] containsObject:@"ad"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"ad"] intValue];
    } else if ([[info allKeys] containsObject:@"adspace"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"adspace"] intValue];
    } else if ([[info allKeys] containsObject:@"adspaceid"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"adspaceid"] intValue];
    } else if ([[info allKeys] containsObject:@"adspaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"adspaceId"] intValue];
    } else if ([[info allKeys] containsObject:@"AdspaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"AdspaceId"] intValue];
    } else if ([[info allKeys] containsObject:@"AdspaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"AdspaceID"] intValue];
    } else if ([[info allKeys] containsObject:@"adspaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"adspaceID"] intValue];
    } else if ([[info allKeys] containsObject:@"AdSpaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"AdSpaceID"] intValue];
    } else if ([[info allKeys] containsObject:@"AdSpaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"AdSpaceId"] intValue];
    } else if ([[info allKeys] containsObject:@"AdSpace"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"AdSpace"] intValue];
    } else if ([[info allKeys] containsObject:@"Ad"]) {
        self.somaBanner.adSettings.adSpaceId=[info[@"Ad"] intValue];
    }
    
//    self.somaBanner.adSettings.httpsOnly = YES;
	
	if (CGSizeEqualToSize(size, MOPUB_BANNER_SIZE)) {
		self.somaBanner.adSettings.dimension = SOMAAdDimensionDefault;
	} else if (CGSizeEqualToSize(size, MOPUB_MEDIUM_RECT_SIZE)) {
		self.somaBanner.adSettings.dimension = SOMAAdDimensionMedRect;
	} else if (CGSizeEqualToSize(size, MOPUB_LEADERBOARD_SIZE)) {
		self.somaBanner.adSettings.dimension = SOMAAdDimensionLeader;
	} else if (CGSizeEqualToSize(size, MOPUB_WIDE_SKYSCRAPER_SIZE)) {
		self.somaBanner.adSettings.dimension = SOMAAdDimensionSky;
	}
	
	self.somaBanner.adSettings.autoReloadEnabled = NO;
	
	
	///////////////////////////////////////////////////////////////////////
	////////////////// SET TARGETTING PARAMETERS //////////////////////////
	///////////////////////////////////////////////////////////////////////
	
	/*************************************
	  Set location from original mopub ad
	 *************************************/
	CLLocation* location =  [self.delegate location];
	if (location) {
		self.somaBanner.adSettings.longitude = location.coordinate.longitude;
		self.somaBanner.adSettings.latitude = location.coordinate.latitude;
	} else {// Set location manually
		//self.somaBanner.adSettings.longitude = LONGITUDE;
		//self.somaBanner.adSettings.latitude = LATITUDE;
	}
	
	
	// UPDATE LOCATION
	//self.somaBanner.adSettings.longitude = LONGITUDE;
	//self.somaBanner.adSettings.latitude = LATITUDE;
	
	/*************************************
	  Set user targetting parameters
	 *************************************/
	// UNCOMMENT THE FOLLOWING LINE FIRST
//	SOMAUserProfile* profile = self.somaBanner.adSettings.userProfile;
	
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
	
	[self.somaBanner load];
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

- (UIViewController *)somaRootViewController{
	return [self.delegate viewControllerForPresentingModalView];
}

- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(bannerCustomEvent:didLoadAd:)]) {
        [self.delegate bannerCustomEvent:self didLoadAd:adview];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
	[adview removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(bannerCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview{
    
}

- (void)somaAdViewWillLeaveApplicationFromAd:(SOMAAdView *)adview {
    if ([self.delegate respondsToSelector:@selector(bannerCustomEventWillLeaveApplication:)]) {
        [self.delegate bannerCustomEventWillLeaveApplication:self];
    }
}

- (void)somaAdViewDidClick:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(bannerCustomEventWillBeginAction:)]) {
        [self.delegate bannerCustomEventWillBeginAction:self];
    }
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(bannerCustomEventDidFinishAction:)]) {
        [self.delegate bannerCustomEventDidFinishAction:self];
    }
}

@end
