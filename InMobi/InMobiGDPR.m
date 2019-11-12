//
//  InMobiGDPR.m
//  InMobiMopubSampleApp
//
//  Created by Vineet Srivastava on 18/05/18.
//
//
#import "InMobiGDPR.h"

static NSString* gdpr=@"0";
static BOOL consent=false;

@implementation InMobiGDPR

+(void)grantConsent{
    consent = true;
}

+(void)revokeConsent{
    consent = false;
}

+(void)isGDPRApplicable: (_Bool) flag{
    if(flag){
        gdpr = @"1";
    } else {
        gdpr = @"0";
    }
}

+(BOOL) getConsent{
    return consent;
}

+(NSString*) isGDPR{
    return gdpr;
}
@end
