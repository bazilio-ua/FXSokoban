//
//  FXCell.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXCell.h"

static const char kFXCellTypeEarth			= '-';
static const char kFXCellTypeWall			= '#';
static const char kFXCellTypeEmpty			= ' ';
static const char kFXCellTypeStone			= '$';
static const char kFXCellTypeTarget			= '.';
static const char kFXCellTypeGem			= '*';
static const char kFXCellTypePlayer			= '@';
static const char kFXCellTypePlayerOnTarget	= '+';

@interface FXCell ()
@property (nonatomic, assign)	char	type;

@end

@implementation FXCell

@dynamic earth;
@dynamic wall;
@dynamic empty;
@dynamic stone;
@dynamic target;
@dynamic gem;
@dynamic player;
@dynamic playerOnTarget;

@dynamic walkable;
@dynamic moveable;

#pragma mark -
#pragma mark Class Methods

+ (id)cell {
	return [[self alloc] initWithType:kFXCellTypeEarth];
}

+ (id)cellWithType:(char)type {
	return [[self alloc] initWithType:type];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithType:(char)type {
	self = [super init];
	if (self) {
		self.type = type;
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isEarth {
	return self.type == kFXCellTypeEarth;
}

- (BOOL)isWall {
	return self.type == kFXCellTypeWall;
}

- (BOOL)isEmpty {
	return self.type == kFXCellTypeEmpty;
}

- (BOOL)isStone {
	return self.type == kFXCellTypeStone;
}

- (BOOL)isTarget {
	return self.type == kFXCellTypeTarget;
}

- (BOOL)isGem {
	return self.type == kFXCellTypeGem;
}

- (BOOL)isPlayer {
	return self.type == kFXCellTypePlayer;
}

- (BOOL)isPlayerOnTarget {
	return self.type == kFXCellTypePlayerOnTarget;
}

- (BOOL)isWalkable {
	char type = self.type;
	
	return type == kFXCellTypeEmpty || type == kFXCellTypeTarget;
}

- (BOOL)isMoveable {
	char type = self.type;
	
	return type == kFXCellTypeStone || type == kFXCellTypeGem;
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)addStone {
	NSUInteger stone = 0;
	char type = self.type;
	switch (type) {
		case kFXCellTypeEmpty:
			type = kFXCellTypeStone;
			stone++;
			break;
			
		case kFXCellTypeTarget:
			type = kFXCellTypeGem;
			break;
			
		default:
			break;
	}
	
	self.type = type;
	
	return stone;
}

- (NSUInteger)removeStone {
	NSUInteger stone = 0;
	char type = self.type;
	switch (type) {
		case kFXCellTypeStone:
			type = kFXCellTypeEmpty;
			stone++;
			break;
			
		case kFXCellTypeGem:
			type = kFXCellTypeTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
	
	return stone;
}

- (void)addPlayer {
	char type = self.type;
	switch (type) {
		case kFXCellTypeEmpty:
			type = kFXCellTypePlayer;
			break;
			
		case kFXCellTypeTarget:
			type = kFXCellTypePlayerOnTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
}

- (void)removePlayer {
	char type = self.type;
	switch (type) {
		case kFXCellTypePlayer:
			type = kFXCellTypeEmpty;
			break;
			
		case kFXCellTypePlayerOnTarget:
			type = kFXCellTypeTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
}

#pragma mark -
#pragma mark NSObject

- (NSString *)description {
	NSString *string = nil;
	switch (self.type) {
		case kFXCellTypeEarth:
			string = @"earth cell";
			break;
			
		case kFXCellTypeWall:
			string = @"wall cell";
			break;
			
		case kFXCellTypeEmpty:
			string = @"empty cell";
			break;
			
		case kFXCellTypeStone:
			string = @"stone cell";
			break;
			
		case kFXCellTypeTarget:
			string = @"empty target cell";
			break;
			
		case kFXCellTypeGem:
			string = @"gem cell (stone on target)";
			break;
			
		case kFXCellTypePlayer:
			string = @"player cell";
			break;
			
		case kFXCellTypePlayerOnTarget:
			string = @"player on target cell";
			break;
			
		default:
			string = @"unknown cell";
			break;
	}
	
	return string;
}

@end
