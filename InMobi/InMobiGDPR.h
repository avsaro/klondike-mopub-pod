//
//  InMobiGDPR.h
//  InMobiMopubSampleApp
//
//  Created by Vineet Srivastava on 18/05/18.
//
//
#import <Foundation/Foundation.h>

@interface InMobiGDPR : NSObject

/**
 * Grants GDPR consent for InMobi AdRequest
 */
+(void)grantConsent;

/**
 * Revokes GDPR consent for InMobi AdRequest
 */
+(void)revokeConsent;
/**
 * Set true/false based on applicability of GDPR
 */
+(void)isGDPRApplicable:(_Bool) flag;

+(BOOL) getConsent;
+(NSString*) isGDPR;
@end
