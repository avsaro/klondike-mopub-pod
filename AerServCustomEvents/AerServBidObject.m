//
//  AerServBidObject.m
//
//  Created on 27/06/18.
//

#import "AerServBidObject.h"
#import "AerServBidder.h"
#import "AerServCustomEventUtils.h"

NSString* const kASKeywordPlacementPattern = @"AS_[0-9]+:";
NSString* const kASKeywordPricePattern = @"[0-9]+.[0-9]{2}";
NSString* const kASKeywordPattern = @"AS_[0-9]+:[0-9]+.[0-9]{2}";

@interface AerServBidObject ()

@property (nonatomic, strong) NSNumber* buyPrice;
@property (nonatomic) BOOL rewarded;

@end

@implementation AerServBidObject

- (instancetype)initBidObjectForPlacement:(NSString*)placement asInterstitial:(ASInterstitialViewController*)asInterstitial mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener {
    AerServBidObject* aerservBidObject = [self initMembers:placement asRewarded:NO aerservBidListener:aerservBidListener];
    aerservBidObject.asInterstitial = asInterstitial;
    aerservBidObject.mpInterstitialAdController = mpInterstitialAdController;
    aerservBidObject.asInterstitial.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Interstitial Bid Price");
    [aerservBidObject.asInterstitial loadAd];
    return aerservBidObject;
}

- (instancetype)initBidObjectForPlacement:(NSString*)placement asBanner:(ASAdView*)asBanner mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener {
    AerServBidObject* aerservBidObject = [self initMembers:placement asRewarded:NO aerservBidListener:aerservBidListener];
    aerservBidObject.asBanner = asBanner;
    aerservBidObject.mpAdView = adView;
    aerservBidObject.asBanner.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Banner Bid Price");
    [aerservBidObject.asBanner loadAd];
    return aerservBidObject;
}

- (instancetype)initBidObjectForPlacement:(NSString*)placement asRewardedInterstitial:(ASInterstitialViewController*)asRewardedInterstitial aerservBidListener:(id)aerservBidListener {
    AerServBidObject* aerservBidObject = [self initMembers:placement asRewarded:YES aerservBidListener:aerservBidListener];
    aerservBidObject.asInterstitial = asRewardedInterstitial;
    aerservBidObject.asInterstitial.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Rewarded Bid Price");
    [aerservBidObject.asInterstitial loadAd];
    return aerservBidObject;
}

- (instancetype)initMembers:(NSString*)placement asRewarded:(BOOL)rewarded aerservBidListener:(id)aerservBidListener{
    if(self = [super init]) {
        _placement = placement;
        _rewarded = rewarded;
        _aerservBidListener = aerservBidListener;
    }
    return self;
}

#pragma mark - keyword helpers

- (NSString*)handleExtraCommasFor:(NSString*)inputStr {
    NSString* outputStr = inputStr;
    if([inputStr isKindOfClass:[NSString class]] && inputStr.length > 0) {
        if([inputStr characterAtIndex:0] == ',') {
            outputStr = [inputStr substringFromIndex:1];
        } else if([inputStr characterAtIndex:inputStr.length-1] == ',') {
            outputStr = [inputStr substringToIndex:inputStr.length-1];
        } else {
            outputStr = [AerServCustomEventUtils replaceString:inputStr withPattern:@",,+" andReplacement:@","];
        }
    }
    return outputStr;
}

- (NSString*)processedKeywords:(NSString*)keywords withRemovalOfPlacement:(NSString*)placement {
    NSString* processedKeywords = keywords;
    if([AerServCustomEventUtils string:keywords containsPattern:kASKeywordPattern]) {
        NSArray* keywordMatches = [AerServCustomEventUtils findMatchesInString:keywords withPattern:kASKeywordPattern];
        for(NSTextCheckingResult* match in keywordMatches) {
            NSString* matchStr = [keywords substringWithRange:match.range];
            if([AerServCustomEventUtils string:matchStr containsPattern:placement]) {
                processedKeywords = [processedKeywords stringByReplacingOccurrencesOfString:matchStr withString:@""];
                processedKeywords = [self handleExtraCommasFor:processedKeywords];
            }
        }
    }
    return (processedKeywords && processedKeywords.length > 0) ? [NSString stringWithFormat:@"%@,", processedKeywords] : @"";
}

#pragma mark - method to fetch keywords for Aerserv Rewarded Ad

- (NSString*)getKeywordsForRewarded:(NSNumber*)buyerprice placement:(NSString*)placement {
    double buyerPrice = [buyerprice doubleValue];
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.50" lowThreshold:10.00 highThreshold:25.00];
    NSString* bidKeyword = [NSString stringWithFormat:@"%@%@", aerservPrefix, bidPrice];
    NSString* existingKeywords = [AerServBidder getSharedBidder].rewardedKeywords;
    NSString* processedKeywords = @"";
    if(existingKeywords && existingKeywords.length > 0) {
        processedKeywords = [self processedKeywords:existingKeywords withRemovalOfPlacement:placement];
        processedKeywords = [processedKeywords stringByAppendingString:bidKeyword];
    } else {
        processedKeywords = bidKeyword;
    }
    [AerServBidder getSharedBidder].rewardedKeywords = processedKeywords;
    return processedKeywords;
}

#pragma mark - method to fetch keywords for Aerserv Interstitial Ad

- (void)setKeywordsForInterstitial:(NSNumber*)buyerprice placement:(NSString*)placement {
    double buyerPrice = [buyerprice doubleValue];
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.50" lowThreshold:10.00 highThreshold:25.00];
    NSString* processedKeywords = [self processedKeywords:self.mpInterstitialAdController.keywords withRemovalOfPlacement:placement];
    self.mpInterstitialAdController.keywords = [NSString stringWithFormat:@"%@%@%@", processedKeywords, aerservPrefix, bidPrice];
}

#pragma mark - method to fetch keywords for Aerserv Banner Ad

- (void)setKeywordsForBanner:(NSNumber*)buyerprice placement:(NSString*)placement {
    double buyerPrice = [buyerprice doubleValue];
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.25" lowThreshold:5.00 highThreshold:10.00];
    NSString* processedKeywords = [self processedKeywords:self.mpAdView.keywords withRemovalOfPlacement:placement];
    self.mpAdView.keywords = [NSString stringWithFormat:@"%@%@%@", processedKeywords, aerservPrefix, bidPrice];
}

#pragma mark - method to set the keywords given the interval pricing and threshold values

- (NSString*)getKeywordForIntervalAndThreshold:(double)buyerPrice interval:(NSString*)interval lowThreshold:(double)lowThreshold highThreshold:(double)highThreshold {
    NSString* keywords = @"";
    if(buyerPrice >= highThreshold) {
        keywords = [NSString stringWithFormat:@"%0.2f", highThreshold];
    } else {
        double decimal = buyerPrice - (int) (buyerPrice);
        if(buyerPrice < lowThreshold) {
            buyerPrice = buyerPrice - decimal;
            if([interval isEqualToString:@"0.50"]) {
                if(decimal >= 0.50) {
                    decimal = 0.50;
                } else {
                    decimal = 0.0;
                }
            } else if([interval isEqualToString:@"0.25"]) {
                if(buyerPrice == 0 && decimal < 0.25) {
                    if(decimal >= 0.1) {
                        decimal = 0.1;
                    } else if(decimal >= 0.01) {
                        decimal = 0.01;
                    } else {
                        decimal = 0.0;
                    }
                } else if(buyerPrice > 0 && decimal < 0.25) {
                    decimal = 0.0;
                } else if(decimal >= 0.25 && decimal < 0.50) {
                    decimal = 0.25;
                } else if(decimal >= 0.50 && decimal < 0.75) {
                    decimal = 0.50;
                } else if(decimal >= 0.75) {
                    decimal = 0.75;
                }
            }
            buyerPrice = buyerPrice + decimal;
        } else {
            buyerPrice = buyerPrice - decimal;
        }
        keywords = [NSString stringWithFormat:@"%0.2f", buyerPrice];
    }
    return keywords;
}

#pragma mark - ASInterstitialViewControllerDelegate methods

- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController*)viewController {
    NSLog(@"AerServBidObject, interstitialViewControllerDidPreloadAd:Aerserv bid interstitial ad loaded.");
    if([self.asInterstitial isEqual:viewController] && [self.buyPrice isKindOfClass:[NSNumber class]]) {
        if(self.rewarded) {
            NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Loading rewarded keywords");
            NSString* rewardedKeywords = [self getKeywordsForRewarded:self.buyPrice placement:self.placement];
            [self.aerservBidListener bidReceived:rewardedKeywords];
        } else{
            NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Loading interstitial keywords");
            [self setKeywordsForInterstitial:self.buyPrice placement:self.placement];
            [self.aerservBidListener bidReceived:self.mpInterstitialAdController];
        }
    }
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController*)viewController withError:(NSError*)error {
    NSLog(@"AerServBidObject, interstitialViewControllerAdFailedToLoad: Aerserv bid interstitial ad failed: %@", error);
    // remove placement from keywords
    NSString* keywords = self.mpInterstitialAdController.keywords;
    NSString* placement = viewController.placementID;
    NSString* processedKeywords = [self processedKeywords:keywords withRemovalOfPlacement:placement];
    self.mpInterstitialAdController.keywords = [self handleExtraCommasFor:processedKeywords];
    
    // remove interstitial from bidding info
    NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
    biddingInfo[placement] = nil;
    
    // dereference interstitial and report bid fail
    self.asInterstitial = nil;
    [self.aerservBidListener bidFailedToLoad:self.mpInterstitialAdController error:error];
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didLoadAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Interstitial ad did load with transaction info: %@", transactionInfo);
    if([transactionInfo[@"buyerPrice"] isKindOfClass:[NSNumber class]]) {
        self.buyPrice = transactionInfo[@"buyerPrice"];
    }
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didShowAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    NSLog(@"AerServBidObject, didShowAdWithTransactionInfo: Interstitial ad did show with transaction info: %@", transactionInfo);
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController*)viewController {
    NSLog(@"AerServBidObject, interstitialViewControllerDidAppear:Aerserv bid interstitial ad shown.");
    self.asInterstitial = nil;
}

#pragma mark - ASAdViewDelegate methods

- (UIViewController*)viewControllerForPresentingModalView {
    return nil;
}

- (void)adViewDidLoadAd:(ASAdView*)adView {
    NSLog(@"AerServBidObject, adViewDidLoadAd:AerServ banner ad loaded.");
}

- (void)adViewDidFailToLoadAd:(ASAdView*)adView withError:(NSError*)error {
    NSLog(@"AerServBidObject, adViewDidFailToLoadAd:AerServ banner failed: %@", error);
    // remove placement from keywords
    NSString* keywords = self.mpAdView.keywords;
    NSString* placement = adView.placementID;
    NSString* processedKeywords = [self processedKeywords:keywords withRemovalOfPlacement:placement];
    self.mpAdView.keywords = [self handleExtraCommasFor:processedKeywords];
    
    // remove ad view from bidding info
    NSMutableDictionary* biddingInfo = [AerServBidder getAerservBiddingInfo];
    biddingInfo[placement] = nil;
    
    // dereference and report bid fail
    self.asBanner = nil;
    [self.aerservBidListener bidFailedToLoad:self.mpAdView error:error];
}

- (void)adView:(ASAdView*)adView didLoadAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Banner ad did load with transaction info: %@", transactionInfo);
    NSNumber* price = transactionInfo[@"buyerPrice"];
    if([self.asBanner isEqual:adView] && [price isKindOfClass:[NSNumber class]]) {
        [self setKeywordsForBanner:price placement:self.placement];
        [self.aerservBidListener bidReceived:self.mpAdView];
    }
}

- (void)adView:(ASAdView*)adView didShowAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    NSLog(@"AerServBidObject, didShowAdWithTransactionInfo: Banner ad did show with transaction info: %@", transactionInfo);
    self.asBanner = nil;
}

@end
