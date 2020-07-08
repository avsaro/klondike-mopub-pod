//
//  InMobiAdapterConfiguration.h
//  InMobiMoPubSampleApp
//
//  Created by Iti Agrawal on 11/09/19.
//

#import <Foundation/Foundation.h>
#import "MoPub.h"
NS_ASSUME_NONNULL_BEGIN

@interface InMobiAdapterConfiguration : MPBaseAdapterConfiguration

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration complete:(void(^ _Nullable)(NSError * _Nullable))complete;

@end

NS_ASSUME_NONNULL_END
