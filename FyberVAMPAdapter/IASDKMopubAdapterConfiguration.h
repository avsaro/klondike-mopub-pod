//
//  IASDKMopubAdapterConfiguration.m
//  IASDKClient
//
//  Created by Inneractive on 2/25/19.
//  Copyright © 2019 Inneractive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPBaseAdapterConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IASDKMopubAdapterError) {
    IASDKMopubAdapterErrorUnknown = 1,
    IASDKMopubAdapterErrorMissingAppID,
    IASDKMopubAdapterErrorInternal,
};

extern NSString * const kIASDKMopubAdapterAppIDKey;
extern NSString * const kIASDKMopubAdapterErrorDomain;

/**
 *  @brief The Inneractive Adapter Configuration class.
 *
 *  @discussion This adapter set of classes is supported only and only by the VAMP SDK that it is shipped with.
 */
@interface IASDKMopubAdapterConfiguration : MPBaseAdapterConfiguration

@end

NS_ASSUME_NONNULL_END
