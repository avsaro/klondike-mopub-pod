//
//  InneractiveNativeAdAdapter.h
//  IASDKClient
//
//  Created by Inneractive on 30/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "MPNativeAdAdapter.h"

@class IANativeUnitController;

@interface InneractiveNativeAdAdapter : NSObject <MPNativeAdAdapter>

@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;

@property (nonatomic, strong) IANativeUnitController *nativeUnitController;
@property (nonatomic, weak) UIView *mainMediaView;
@property (nonatomic) BOOL isVideoAd;

- (instancetype)initWithInneractiveNativeUnitController:(IANativeUnitController *)nativeUnitController;

@end
