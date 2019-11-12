//
//  InneractiveNativeAdRenderingAdapterView.h
//  IASDKClient
//
//  Created by Inneractive on 31/12/15.
//  Copyright © 2017 Inneractive. All rights reserved.
//

#import "MPNativeAdRendering.h"

#import <IASDKCore/IAInterfaceNativeRenderer.h>

/**
 *  @protocol InneractiveDynamicSizeDelegate
 *  @brief Dynamic size support infrastructure.
 */
@protocol InneractiveDynamicSizeDelegate <NSObject>

@required
- (NSNumber *)isDynamicSize;

@end

/**
 * InneractiveNativeAdRenderingAdapterView class instance will load all needed assets data into provided rendering view class,
 * that conforms to 'MPNativeAdRendering' protocol.
 */
@interface InneractiveNativeAdRenderingAdapterView : UIView <IAInterfaceNativeRenderer, InneractiveDynamicSizeDelegate>

@property (nonatomic, strong) UIView<MPNativeAdRendering> *adView;

@property (nonatomic, weak) UIView *mainMediaView;

@property (nonatomic, strong) NSNumber *isDynamicSize; // Dynamic size support infrastructure.

@property (nonatomic) BOOL isVideoAd;

- (instancetype)initWithAdView:(UIView<MPNativeAdRendering> *)adView isDynamicSize:(BOOL)isDynamicSize;

@end
