//
//  FXDirection.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FXPosition;

@interface FXDirection : NSObject
@property (nonatomic, readonly)	FXDirection		*inverseDirection;

+ (FXDirection *)directionMoveUp;
+ (FXDirection *)directionMoveDown;
+ (FXDirection *)directionMoveRight;
+ (FXDirection *)directionMoveLeft;

+ (FXDirection *)directionBetweenFromPosition:(FXPosition *)fromPosition
								   toPosition:(FXPosition *)toPosition;

- (FXPosition *)positionMovedFromPosition:(FXPosition *)position;

@end
