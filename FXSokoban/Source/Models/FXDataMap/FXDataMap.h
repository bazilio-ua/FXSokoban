//
//  FXDataMap.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FXLevel;

@interface FXDataMap : NSObject

- (NSUInteger)count;
- (FXLevel *)levelForNumber:(NSUInteger)number;

@end
