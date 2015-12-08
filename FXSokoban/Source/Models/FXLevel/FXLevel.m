//
//  FXLevel.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXLevel.h"

#import "FXLevelObserver.h"

#import "FXCell.h"
#import "FXPosition.h"
#import "FXDirection.h"

@interface FXLevel ()
@property (nonatomic, strong)	NSUndoManager	*undoManager;
@property (nonatomic, strong)	NSDictionary	*cells;
@property (nonatomic, assign)	NSInteger		rows;
@property (nonatomic, assign)	NSInteger		columns;
@property (nonatomic, assign)	NSUInteger		moves;
@property (nonatomic, assign)	NSUInteger		pushes;
@property (nonatomic, assign)	NSUInteger		goals;
@property (nonatomic, assign)	NSUInteger		packets;

- (NSDictionary *)cellsFromArray:(NSArray *)array;

@end

@implementation FXLevel

@dynamic finished;

#pragma mark -
#pragma mark Class Methods

+ (id)levelWithArray:(NSArray *)array {
	return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.undoManager = nil;
	self.cells = nil;
}

- (id)initWithArray:(NSArray *)array {
	self = [super init];
	if (self) {
		self.undoManager = [[NSUndoManager alloc] init];
		self.cells = [self cellsFromArray:array];
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)finished {
	return self.packets == 0;
}

#pragma mark -
#pragma mark Overloaded Methods

- (SEL)selectorForState:(NSUInteger)state {
	SEL selector = NULL;
	switch (state) {
		case kFXLevelDidChange:
			selector = @selector(levelDidChange:);
			break;
			
		case kFXLevelDidFinish:
			selector = @selector(levelDidFinish:);
			break;
			
		default:
			break;
	}
	
	return selector;
}

#pragma mark -
#pragma mark Public Methods

- (FXLevel *)snapshot {
	FXLevel *level = [[FXLevel alloc] init];
	level.cells = self.cells;
	level.playerPosition = self.playerPosition;
	level.rows = self.rows;
	level.columns = self.columns;
	level.packets = self.packets;
	
	return level;
}

- (FXCell *)cellAtPosition:(FXPosition *)position {
	FXCell *cell = self.cells[position];
	if (!cell) {
		cell = [FXCell cell];
	}
	
	return cell;
}

- (BOOL)canWalkInDirection:(FXDirection *)direction {
	FXPosition *nextPosition = [direction positionMovedFromPosition:self.playerPosition];
	
	return [[self cellAtPosition:nextPosition] isWalkable];
}

- (BOOL)canPushInDirection:(FXDirection *)direction {
	FXPosition *nextPlayerPosition = [direction positionMovedFromPosition:self.playerPosition];
	FXPosition *nextTargetPosition = [direction positionMovedFromPosition:nextPlayerPosition];
	
	return [[self cellAtPosition:nextPlayerPosition] isMoveable] && [[self cellAtPosition:nextTargetPosition] isWalkable];
}

- (void)walkInDirection:(FXDirection *)direction {
	if ([self canWalkInDirection:direction]) {
		FXPosition *playerPosition = self.playerPosition;
		FXPosition *nextPlayerPosition = [direction positionMovedFromPosition:playerPosition];
		[[self cellAtPosition:playerPosition] removePlayer];
		[[self cellAtPosition:nextPlayerPosition] addPlayer];
		self.playerPosition = nextPlayerPosition;
		self.moves = self.moves + 1;
		
		[self registerUndoActionWithSelector:@selector(walkInDirection:) oldDirection:direction];
		self.state = kFXLevelDidChange;
	}
}

- (void)pushInDirection:(FXDirection *)direction {
	if ([self canPushInDirection:direction]) {
		FXPosition *playerPosition = self.playerPosition;
		FXPosition *nextPlayerPosition = [direction positionMovedFromPosition:playerPosition];
		FXPosition *nextTargetPosition = [direction positionMovedFromPosition:nextPlayerPosition];
		[[self cellAtPosition:playerPosition] removePlayer];
		FXCell *nextPlayerCell = [self cellAtPosition:nextPlayerPosition];
		self.packets = self.packets - [nextPlayerCell removePacket];
		[nextPlayerCell addPlayer];
		self.packets = self.packets + [[self cellAtPosition:nextTargetPosition] addPacket];
		self.playerPosition = nextPlayerPosition;
		self.moves = self.moves + 1;
		self.pushes = self.pushes + 1;
		
		[self registerUndoActionWithSelector:@selector(pullInDirection:) oldDirection:direction];
		self.state = kFXLevelDidChange;
	}
}

- (void)pullInDirection:(FXDirection *)direction { // undo
	FXPosition *playerPosition = self.playerPosition;
	FXPosition *nextPlayerPosition = [direction positionMovedFromPosition:playerPosition];
	FXCell *nextPlayerCell = [self cellAtPosition:nextPlayerPosition];
	FXPosition *previousTargetPosition = [direction.inverseDirection positionMovedFromPosition:playerPosition];
	FXCell *previousTargetCell = [self cellAtPosition:previousTargetPosition];
	
	if ([nextPlayerCell isWalkable] && [previousTargetCell isMoveable]) {
		FXCell *currentPlayerCell = [self cellAtPosition:playerPosition];
		[currentPlayerCell removePlayer];
		[nextPlayerCell addPlayer];
		self.packets = self.packets - [previousTargetCell removePacket];
		self.packets = self.packets + [currentPlayerCell addPacket];
		self.playerPosition = nextPlayerPosition;
		
		[self registerUndoActionWithSelector:@selector(pushInDirection:) oldDirection:direction];
		self.state = kFXLevelDidChange;
	}
}

- (void)registerUndoActionWithSelector:(SEL)selector oldDirection:(FXDirection *)oldDirection {
	if (self.undoManager) {
		[self.undoManager registerUndoWithTarget:self
										selector:selector
										  object:oldDirection.inverseDirection];
	}
}

#pragma mark -
#pragma mark Private Methods

- (NSDictionary *)cellsFromArray:(NSArray *)array {
	NSMutableDictionary *cells = [NSMutableDictionary dictionary];
	for (NSString *row in array) {
		NSInteger columnCount;
		for (columnCount = 0; columnCount < [row length]; columnCount++) {
			FXPosition *position = [FXPosition positionWithPointX:self.rows pointY:columnCount];
			FXCell *cell = [FXCell cellWithType:[row characterAtIndex:columnCount]];
			if ([cell isPlayer] || [cell isPlayerOnTarget]) {
				self.playerPosition = position;
			}
			
			if ([cell isPacket]) {
				self.packets =  self.packets + 1;
			}
			
			cells[position] = cell;
		}
		
		if (columnCount > self.columns) {
			self.columns = columnCount;
		}
		
		self.rows = self.rows + 1;
	}
	
	return [NSDictionary dictionaryWithDictionary:cells];
}

@end
