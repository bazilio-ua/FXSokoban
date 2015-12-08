//
//  FXDirection.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXDirection.h"

#import "FXPosition.h"

static const NSInteger	kFXDirectionDeltaX[4] = {-1, 1, 0, 0};
static const NSInteger	kFXDirectionDeltaY[4] = {0, 0, 1, -1};

NS_ENUM(NSInteger, FXDirectionMoves) {
	kFXDirectionMoveUp		= 0,
	kFXDirectionMoveDown	= 1,
	kFXDirectionMoveRight	= 2,
	kFXDirectionMoveLeft	= 3,
};

@interface FXDirection ()
@property (nonatomic, strong)	FXDirection		*reverseDirection;
@property (nonatomic, assign)	NSInteger		deltaX;
@property (nonatomic, assign)	NSInteger		deltaY;

+ (FXDirection *)directionForMove:(NSInteger)directionMove withReverseMove:(NSInteger)reverseMove;

@end

@implementation FXDirection

#pragma mark -
#pragma mark Class Methods

+ (FXDirection *)directionForMove:(NSInteger)directionMove withReverseMove:(NSInteger)reverseMove {
	static FXDirection *__directions[4] = {nil, nil, nil, nil};
	if (!__directions[directionMove]) {
		__directions[directionMove] = [[FXDirection alloc] init];
		__directions[directionMove].reverseDirection = [FXDirection directionForMove:reverseMove
																	 withReverseMove:directionMove];
		__directions[directionMove].deltaX = kFXDirectionDeltaX[directionMove];
		__directions[directionMove].deltaY = kFXDirectionDeltaY[directionMove];
	}
	
	return __directions[directionMove];
}

+ (FXDirection *)directionMoveUp {
	return [FXDirection directionForMove:kFXDirectionMoveUp withReverseMove:kFXDirectionMoveDown];
}

+ (FXDirection *)directionMoveDown {
	return [FXDirection directionForMove:kFXDirectionMoveDown withReverseMove:kFXDirectionMoveUp];
}

+ (FXDirection *)directionMoveRight {
	return [FXDirection directionForMove:kFXDirectionMoveRight withReverseMove:kFXDirectionMoveLeft];
}

+ (FXDirection *)directionMoveLeft {
	return [FXDirection directionForMove:kFXDirectionMoveLeft withReverseMove:kFXDirectionMoveRight];
}

+ (FXDirection *)directionBetweenFromPosition:(FXPosition *)fromPosition toPosition:(FXPosition *)toPosition {
	NSInteger deltaX = toPosition.x - fromPosition.x;
	NSInteger deltaY = toPosition.y - fromPosition.y;
	
	FXDirection *direction = nil;
	SEL selectors[4] = {
		@selector(directionMoveUp),
		@selector(directionMoveDown),
		@selector(directionMoveRight),
		@selector(directionMoveLeft)
	};
	
	for (NSUInteger index = 0; index < 4; index++) {
		direction = [FXDirection performSelector:selectors[index]];
		if (direction.deltaX == deltaX && direction.deltaY == deltaY) {
			return direction;
		}
	}
	
	return nil;
}

#pragma mark -
#pragma mark Public Methods

- (FXPosition *)positionMovedFromPosition:(FXPosition *)position {
	return [FXPosition positionWithPointX:position.x + self.deltaX pointY:position.y + self.deltaY];
}

@end
