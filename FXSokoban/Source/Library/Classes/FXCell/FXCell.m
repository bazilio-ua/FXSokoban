//
//  FXCell.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXCell.h"

static const char kFXEarth			= '-';
static const char kFXWall			= '#';
static const char kFXEmpty			= ' ';
static const char kFXStone			= '$';
static const char kFXTarget			= '.';
static const char kFXGem			= '*';
static const char kFXPlayer			= '@';
static const char kFXPlayerOnTarget	= '+';

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
	return self.type == kFXEarth;
}

- (BOOL)isWall {
	return self.type == kFXWall;
}

- (BOOL)isEmpty {
	return self.type == kFXEmpty;
}

- (BOOL)isStone {
	return self.type == kFXStone;
}

- (BOOL)isTarget {
	return self.type == kFXTarget;
}

- (BOOL)isGem {
	return self.type == kFXGem;
}

- (BOOL)isPlayer {
	return self.type == kFXPlayer;
}

- (BOOL)isPlayerOnTarget {
	return self.type == kFXPlayerOnTarget;
}

- (BOOL)isWalkable {
	char type = self.type;
	
	return type == kFXEmpty || type == kFXTarget;
}

- (BOOL)isMoveable {
	char type = self.type;
	
	return type == kFXStone || type == kFXGem;
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)addStone {
	NSUInteger stone = 0;
	char type = self.type;
	switch (type) {
		case kFXEmpty:
			type = kFXStone;
			stone++;
			break;
			
		case kFXTarget:
			type = kFXGem;
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
		case kFXStone:
			type = kFXEmpty;
			stone++;
			break;
			
		case kFXGem:
			type = kFXTarget;
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
		case kFXEmpty:
			type = kFXPlayer;
			break;
			
		case kFXTarget:
			type = kFXPlayerOnTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
}

- (void)removePlayer {
	char type = self.type;
	switch (type) {
		case kFXPlayer:
			type = kFXEmpty;
			break;
			
		case kFXPlayerOnTarget:
			type = kFXTarget;
			break;
			
		default:
			break;
	}
	
	self.type = type;
}

#pragma mark -
#pragma mark NSObject

- (NSString *)description {
	NSString *string = [NSString string];
	switch (self.type) {
		case kFXEarth:
			string = @"earth cell";
			break;
			
		case kFXWall:
			string = @"wall cell";
			break;
			
		case kFXEmpty:
			string = @"empty cell";
			break;
			
		case kFXStone:
			string = @"stone cell";
			break;
			
		case kFXTarget:
			string = @"empty target cell";
			break;
			
		case kFXGem:
			string = @"gem cell (stone on target)";
			break;
			
		case kFXPlayer:
			string = @"player cell";
			break;
			
		case kFXPlayerOnTarget:
			string = @"player on target cell";
			break;
			
		default:
			string = @"unknown cell";
			break;
	}
	
	return string;
}

@end
