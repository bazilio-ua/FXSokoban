//
//  FXPath.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FXLevel;
@class FXPosition;

@interface FXPath : NSObject

+ (id)pathWithLevel:(FXLevel *)level;
- (id)initWithLevel:(FXLevel *)level;

- (NSArray *)pathToPosition:(FXPosition *)position;

@end
