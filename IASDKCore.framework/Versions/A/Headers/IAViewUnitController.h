//
//  IAViewUnitController.h
//  IASDKCore
//
//  Created by Fyber on 14/03/2017.
//  Copyright © 2017 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <IASDKCore/IAInterfaceBuilder.h>
#import <IASDKCore/IAUnitController.h>
#import <IASDKCore/IAUnitDelegate.h>

/**
 *  @brief Builder block. 'self' can be used. The block is not retained.
 */
@protocol IAViewUnitControllerBuilder <IAUnitControllerBuilderProtocol>

@required
@property (nonatomic, weak, nullable) id<IAUnitDelegate> unitDelegate;

@end

@class IAAdView;

@interface IAViewUnitController : IAUnitController <IAInterfaceBuilder, IAViewUnitControllerBuilder>

@property (nonatomic, strong, readonly, nullable) IAAdView *adView;

+ (instancetype _Nullable)build:(void(^ _Nonnull)(id<IAViewUnitControllerBuilder> _Nonnull builder))buildBlock;

- (void)showAdInParentView:(UIView * _Nonnull)parentView;

@end
