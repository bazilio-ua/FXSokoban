//
//  FXDirection.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXDirection.h"

#import "FXPosition.h"

static const NSInteger kFXDeltaX[4] = {-1, 1, 0, 0};
static const NSInteger kFXDeltaY[4] = {0, 0, 1, -1};

NS_ENUM(NSInteger, FXDirectionMoves) {
	kFXDirectionMoveUp		= 0,
	kFXDirectionMoveDown	= 1,
	kFXDirectionMoveRight	= 2,
	kFXDirectionMoveLeft	= 3,
};

@interface FXDirection ()
@property (nonatomic, strong)	FXDirection		*inverseDirection;
@property (nonatomic, assign)	NSInteger		deltaX;
@property (nonatomic, assign)	NSInteger		deltaY;

+ (FXDirection *)directionForMove:(NSInteger)directionMove withInverseMove:(NSInteger)inverseMove;

@end

@implementation FXDirection

#pragma mark -
#pragma mark Class Methods

+ (FXDirection *)directionMoveUp {
	return [FXDirection directionForMove:kFXDirectionMoveUp withInverseMove:kFXDirectionMoveDown];
}

+ (FXDirection *)directionMoveDown {
	return [FXDirection directionForMove:kFXDirectionMoveDown withInverseMove:kFXDirectionMoveUp];
}

+ (FXDirection *)directionMoveRight {
	return [FXDirection directionForMove:kFXDirectionMoveRight withInverseMove:kFXDirectionMoveLeft];
}

+ (FXDirection *)directionMoveLeft {
	return [FXDirection directionForMove:kFXDirectionMoveLeft withInverseMove:kFXDirectionMoveRight];
}

+ (FXDirection *)directionBetweenFromPosition:(FXPosition *)fromPosition toPosition:(FXPosition *)toPosition {
	NSInteger deltaX = toPosition.x - fromPosition.x;
	NSInteger deltaY = toPosition.y - fromPosition.y;
	
	FXDirection *direction;
	direction = [FXDirection directionMoveUp];
	if (direction.deltaX == deltaX && direction.deltaY == deltaY) {
		return direction;
	}
	
	direction = [FXDirection directionMoveDown];
	if (direction.deltaX == deltaX && direction.deltaY == deltaY) {
		return direction;
	}
	
	direction = [FXDirection directionMoveRight];
	if (direction.deltaX == deltaX && direction.deltaY == deltaY) {
		return direction;
	}
	
	direction = [FXDirection directionMoveLeft];
	if (direction.deltaX == deltaX && direction.deltaY == deltaY) {
		return direction;
	}
	
	return nil;
}

#pragma mark -
#pragma mark Public Methods

- (FXPosition *)positionMovedFromPosition:(FXPosition *)position {
	return [FXPosition positionWithCoordinateX:position.x + self.deltaX CoordinateY:position.y + self.deltaY];
}

#pragma mark -
#pragma mark Private Class Methods

+ (FXDirection *)directionForMove:(NSInteger)directionMove withInverseMove:(NSInteger)inverseMove {
	static FXDirection *__directions[4] = {nil, nil, nil, nil};
	if (!__directions[directionMove]) {
		__directions[directionMove] = [[FXDirection alloc] init];
		__directions[directionMove].inverseDirection = [FXDirection directionForMove:inverseMove
																	 withInverseMove:directionMove];
		__directions[directionMove].deltaX = kFXDeltaX[directionMove];
		__directions[directionMove].deltaY = kFXDeltaY[directionMove];
	}
	
	return __directions[directionMove];
}

@end
