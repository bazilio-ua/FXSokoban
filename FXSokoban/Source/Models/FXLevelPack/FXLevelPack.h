//
//  FXLevelPack.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FXLevel;

@interface FXLevelPack : NSObject

+ (FXLevelPack *)sharedInstance;

- (NSUInteger)count;
- (FXLevel *)levelAtIndex:(NSUInteger)index;

@end
