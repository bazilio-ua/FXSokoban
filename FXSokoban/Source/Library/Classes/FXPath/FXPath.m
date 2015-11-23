//
//  FXPath.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXPath.h"

#import "FXLevel.h"
#import "FXPosition.h"
#import "FXDirection.h"

@interface FXPath ()
@property (nonatomic, strong)	FXLevel		*level;

- (void)moveToDirection:(FXDirection *)direction
		   fromPosition:(FXPosition *)position
	  previousPositions:(NSMutableDictionary *)previousPositions
		  nextPositions:(NSMutableArray *)nextPositions;

@end

@implementation FXPath

#pragma mark -
#pragma mark Class Methods

+ (id)pathWithLevel:(FXLevel *)level {
	return [[self alloc] initWithLevel:level];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.level = nil;
}

- (id)initWithLevel:(FXLevel *)level {
	self = [super init];
	if (self) {
		self.level = [level snapshot];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSArray *)pathToPosition:(FXPosition *)position {
	FXPosition *playerPosition = self.level.playerPosition;
	NSMutableArray *nextPositions = [NSMutableArray arrayWithObject:playerPosition];
	NSMutableDictionary *previousPositions = [NSMutableDictionary dictionary];
	
	while ([nextPositions count] > 0) {
		FXPosition *currentPosition = nextPositions[0];
		[nextPositions removeObjectAtIndex:0];
		if ([currentPosition isEqual:position]) {
			[nextPositions removeAllObjects];
			while (![currentPosition isEqual:playerPosition]) {
				FXDirection *backTrace = previousPositions[currentPosition];
				currentPosition = [backTrace positionMovedFromPosition:currentPosition];
				[nextPositions insertObject:[backTrace inverseDirection] atIndex:0];
			}
			
			return nextPositions;
		}
		
		self.level.playerPosition = currentPosition;
		
		SEL selectors[4] = {
			@selector(directionMoveUp),
			@selector(directionMoveDown),
			@selector(directionMoveRight),
			@selector(directionMoveLeft)
		};
		
		for (NSUInteger index = 0; index < 4; index++) {
			[self moveToDirection:[FXDirection performSelector:selectors[index]]
					 fromPosition:currentPosition
				previousPositions:previousPositions
					nextPositions:nextPositions];
		}
	}
	
	return nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)moveToDirection:(FXDirection *)direction
		   fromPosition:(FXPosition *)position
	  previousPositions:(NSMutableDictionary *)previousPositions
		  nextPositions:(NSMutableArray *)nextPositions
{
	FXPosition *nextPosition = [direction positionMovedFromPosition:position];
	if (!previousPositions[nextPosition]) {
		if ([self.level canWalkInDirection:direction]) {
			previousPositions[nextPosition] = [direction inverseDirection];
			[nextPositions addObject:nextPosition];
		}
	}
}

@end
