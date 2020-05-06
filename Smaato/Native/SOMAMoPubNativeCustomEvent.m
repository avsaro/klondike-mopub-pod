//
//  SOMAMoPubNativeLayoutAdapter.m
//  iSoma
//
//  Created by Aman Shaikh on 14.07.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SOMAMoPubNativeCustomEvent.h"
#import "MPNativeAdConstants.h"
#import "SOMAMoPubNativeAdAdapter.h"
#import "MPNativeAd.h"
#import <iSoma/iSoma.h>

@interface SOMAMoPubNativeCustomEvent()
@property SOMANativeAd* somaNativeAd;
@end

@implementation SOMAMoPubNativeCustomEvent
-(void)dealloc {
    
}

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info{
	NSLog(@"SOMAMoPubNativeLayoutAdapter: requesting ad with custom ad info: %@", info);
	
	if (info == nil) {
        if ([self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:@"SOMAMoPubNativeLayoutAdapterNilInfo" code:400 userInfo:nil]];
            });
        }
		NSLog(@"Please put a valid json in 'CUSTOM EVENT CLASS DATA' section on mopub dashboard e.g. {\"pub\":\"0\",\"ad\":\"3075\"}");
	}
	
	NSString* publisherId = @"0";
	NSString* adspaceId = info[@"ad"];
	
    if ([[info allKeys] containsObject:@"pub"]) {
        publisherId=info[@"pub"];
    } else if ([[info allKeys] containsObject:@"publisher"]) {
        publisherId=info[@"publisher"];
    } else if ([[info allKeys] containsObject:@"publisherid"]) {
        publisherId=info[@"publisherid"];
    } else if ([[info allKeys] containsObject:@"publisherId"]) {
        publisherId=info[@"publisherId"];
    } else if ([[info allKeys] containsObject:@"PublisherId"]) {
        publisherId=info[@"PublisherId"];
    } else if ([[info allKeys] containsObject:@"PublisherID"]) {
        publisherId=info[@"PublisherID"];
    } else if ([[info allKeys] containsObject:@"publisherID"]) {
        publisherId=info[@"publisherID"];
    } else if ([[info allKeys] containsObject:@"Publisher"]) {
        publisherId=info[@"Publisher"];
    }
    
    if ([[info allKeys] indexOfObject:@"ad"]) {
        adspaceId=info[@"ad"];
    } else if ([[info allKeys] containsObject:@"adspace"]) {
        adspaceId=info[@"adspace"];
    } else if ([[info allKeys] containsObject:@"adspaceid"]) {
        adspaceId=info[@"adspaceid"];
    } else if ([[info allKeys] containsObject:@"adspaceId"]) {
        adspaceId=info[@"adspaceId"];
    } else if ([[info allKeys] containsObject:@"AdspaceId"]) {
        adspaceId=info[@"AdspaceId"];
    } else if ([[info allKeys] containsObject:@"AdspaceID"]) {
        adspaceId=info[@"AdspaceID"];
    } else if ([[info allKeys] containsObject:@"adspaceID"]) {
        adspaceId=info[@"adspaceID"];
    } else if ([[info allKeys] containsObject:@"AdSpaceID"]) {
        adspaceId=info[@"AdSpaceID"];
    } else if ([[info allKeys] containsObject:@"AdSpaceId"]) {
        adspaceId=info[@"AdSpaceId"];
    } else if ([[info allKeys] containsObject:@"AdSpace"]) {
        adspaceId=info[@"AdSpace"];
    } else if ([[info allKeys] containsObject:@"Ad"]) {
        adspaceId=info[@"Ad"];
    }

	if (publisherId == nil || adspaceId == nil) {
        if ([self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:@"SOMAMoPubNativeLayoutAdapterInvalidInfo" code:400 userInfo:nil]];
            });
        }
		NSLog(@"Please put a valid json in 'CUSTOM EVENT CLASS DATA' section on mopub dashboard e.g. {\"pub\":\"0\",\"ad\":\"3075\"}");
	}
	
	
	self.somaNativeAd = [[SOMANativeAd alloc] initWithPublisherId:publisherId adSpaceId:adspaceId];
	
	// UPDATE LOCATION
	//self.somaBanner.adSettings.longitude = LONGITUDE;
	//self.somaBanner.adSettings.latitude = LATITUDE;
	
	/*************************************
	 Set user targetting parameters
	 *************************************/
	// UNCOMMENT THE FOLLOWING LINE FIRST
//		SOMAUserProfile* profile = self.somaNativeAd.adSettings.userProfile;
	
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

	__weak SOMAMoPubNativeCustomEvent* weakSelf = self;
	[self.somaNativeAd requestAd:^(SOMANativeAdObject *dto, NSError *error) {

		if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([weakSelf.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
                    [weakSelf.delegate nativeCustomEvent:weakSelf didFailToLoadAdWithError:error];
                }
            });
			NSLog(@"SOMAMoPubNativeLayoutAdapter Request failed: %@", [error localizedDescription]);
			return;
		}
		
		if (dto == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([weakSelf.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
                    [weakSelf.delegate nativeCustomEvent:weakSelf didFailToLoadAdWithError:[NSError errorWithDomain:@"SOMAMoPubNativeLayoutAdapterInvalidSOMAResponse" code:400 userInfo:nil]];
                }
            });
			NSLog(@"SOMAMoPubNativeLayoutAdapter Received invalid response, please ensure valid publisher id and adspace id");
			return;
		}
		
		NSMutableDictionary* dic = [NSMutableDictionary new];
        dic[kAdTitleKey] = dto.title;
        dic[kAdTextKey] = dto.descriptionText;
        dic[kAdIconImageKey] = dto.assetIconURL.absoluteString;
        dic[kAdMainImageKey] = dto.assetMainURL.absoluteString;
        dic[kAdStarRatingKey] = [NSNumber numberWithFloat:dto.rating];
        dic[kAdCTATextKey] = dto.CTAText;
        dic[kDefaultActionURLKey] = dto.nativeURL.absoluteString;
//        dic[kImpressionTrackerURLsKey] = dto.impressionTrackersUrls;
        dic[kClickTrackerURLKey] = dto.clickTrackersUrls;
        
        SOMAMoPubNativeAdAdapter* adapter = [[SOMAMoPubNativeAdAdapter alloc] init:[dic copy] withDefaultActionURL:dto.nativeURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.delegate respondsToSelector:@selector(nativeCustomEvent:didLoadAd:)]) {
                [weakSelf.delegate nativeCustomEvent:weakSelf didLoadAd:[[MPNativeAd alloc] initWithAdAdapter:adapter]];
            }
        });
	}];
}
@end
