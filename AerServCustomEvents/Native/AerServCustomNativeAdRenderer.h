//
//  AerServCustomNativeAdRenderer.h
//  ASMoPubSDKSampleApp
//
//  Created by Albert Zhu on 7/20/17.
//  Copyright © 2017 AerServ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MoPub.h"

@interface AerServCustomNativeAdRenderer : NSObject <MPNativeAdRenderer>

@property (nonatomic, readonly) MPNativeViewSizeHandler viewSizeHandler;

@end
