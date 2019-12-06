//
//  AerServBidListener.h
//
//  Created on 18/06/18.
//

#import <Foundation/Foundation.h>

@protocol AerServBidListenerDelegate <NSObject>

- (void)bidReceived:(id)mpObject;
- (void)bidFailedToLoad:(id)mpObject error:(NSError*)error;

@end
