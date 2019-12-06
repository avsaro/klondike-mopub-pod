//
//  ASAdView+UnityCheck.h
//  AerServSDK
//
//  Created by Albert Zhu on 9/12/16.
//  Copyright © 2016 AerServ, LLC. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>

@interface ASAdView (UnityCheck)

+ (BOOL)getIsUnity;
+ (void)setIsUnity:(BOOL)val;

@end
