//
//  FXCell.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXCell.h"

static const char kFXCellTypeGround			= '-';
static const char kFXCellTypeWall			= '#';
static const char kFXCellTypeEmpty			= ' ';
static const char kFXCellTypePacket			= '$';
static const char kFXCellTypeTarget			= '.';
static const char kFXCellTypeGoal			= '*';
static const char kFXCellTypePlayer			= '@';
static const char kFXCellTypePlayerOnTarget	= '+';

@interface FXCell ()
@property (nonatomic, assign)	char	type;

@end

@implementation FXCell

@dynamic ground;
@dynamic wall;
@dynamic empty;
@dynamic packet;
@dynamic target;
@dynamic goal;
@dynamic player;
@dynamic playerOnTarget;

@dynamic walkable;
@dynamic moveable;

#pragma mark -
#pragma mark Class Methods

+ (id)cell {
	return [[FXCell alloc] initWithType:kFXCellTypeGround];
}

+ (id)cellWithType:(char)type {
	return [[FXCell alloc] initWithType:type];
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

- (BOOL)isGround {
	return self.type == kFXCellTypeGround;
}

- (BOOL)isWall {
	return self.type == kFXCellTypeWall;
}

- (BOOL)isEmpty {
	return self.type == kFXCellTypeEmpty;
}

- (BOOL)isPacket {
	return self.type == kFXCellTypePacket;
}

- (BOOL)isTarget {
	return self.type == kFXCellTypeTarget;
}

- (BOOL)isGoal {
	return self.type == kFXCellTypeGoal;
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
	
	return type == kFXCellTypePacket || type == kFXCellTypeGoal;
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)addPacket {
	NSUInteger packet = 0;
	char type = self.type;
	switch (type) {
		case kFXCellTypeEmpty:
			type = kFXCellTypePacket;
			packet++;
			break;
			
		case kFXCellTypeTarget:
			type = kFXCellTypeGoal;
			break;
			
		default:
			break;
	}
	
	self.type = type;
	
	return packet;
}

- (NSUInteger)removePacket {
	NSUInteger packet = 0;
	char type = self.type;
	switch (type) {
		case kFXCellTypePacket:
			type = kFXCellTypeEmpty;
			packet++;
			break;
			
		case kFXCellTypeGoal:
			type = kFXCellTypeTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
	
	return packet;
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
		case kFXCellTypeGround:
			string = @"ground cell";
			break;
			
		case kFXCellTypeWall:
			string = @"wall cell";
			break;
			
		case kFXCellTypeEmpty:
			string = @"empty cell";
			break;
			
		case kFXCellTypePacket:
			string = @"packet cell";
			break;
			
		case kFXCellTypeTarget:
			string = @"empty target cell";
			break;
			
		case kFXCellTypeGoal:
			string = @"goal cell (packet on target)";
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
