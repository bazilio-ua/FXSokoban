//
//  FXGameView.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXGameView.h"

#import "FXLevel.h"
#import "FXPosition.h"
#import "FXCell.h"
#import "FXPath.h"
#import "FXDirection.h"

static const NSUInteger kFXCellWidth	= 16;
static const NSUInteger kFXCellHeight	= 16;

static const NSTimeInterval kFXTimeInterval	= 0.05;

@interface FXGameView ()
@property (nonatomic, strong)	NSMutableArray *availableMoves;

- (void)noAvailableMoves;
- (void)setupTimer;
- (void)firedTimerWithUserInfo:(id)userInfo;
- (void)checkNextLevel;

@end

@implementation FXGameView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.level = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setLevel:(FXLevel *)level {
	if (_level != level) {
		[_level removeObserver:self];
		_level = level;
		[_level addObserver:self];
	}
	
	[self setupFrameWithLevel:level];
}

- (void)drawRect:(CGRect)rect {
	FXLevel *level = self.level;
	NSInteger rows = level.rows;
	NSInteger columns = level.columns;

	UIView *levelView = self.levelView;
	CGRect frame = levelView.frame;
	
	for (NSInteger row = 0; row < rows; row++) {
		for (NSInteger column = 0; column < columns; column++) {
//			NSLog(@"row: %d column: %d", row, column);
			
			CGRect cellRect = CGRectMake(column * kFXCellWidth + frame.origin.x,
										 row * kFXCellHeight + frame.origin.y,
										 kFXCellWidth,
										 kFXCellHeight);
			
//			NSLog(@"coord: x %f y %f", cellRect.origin.x, cellRect.origin.y);
			
			FXPosition *position = [FXPosition positionWithCoordinateX:row CoordinateY:column];
			FXCell *cell = [level cellAtPosition:position];
//			NSLog(@"cell: %@, position x:%d y:%d", [cell description], position.x, position.y);
			
			if ([cell isStone]) {
				[[UIColor orangeColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isGem]) {
				[[UIColor yellowColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isTarget]) {
				[[UIColor blueColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isWall]) {
				[[UIColor blackColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isEarth]) {
				[[UIColor brownColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isPlayer] || [cell isPlayerOnTarget]) {
				[[UIColor redColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			}
			
		}
	}
}

#pragma mark -
#pragma mark Public Methods

- (void)setupFrameWithLevel:(FXLevel *)level {
	UIView *levelView = self.levelView;
	CGRect frame = levelView.frame;
	CGRect bounds = levelView.bounds;
	
	CGFloat width = level.columns * kFXCellWidth - CGRectGetWidth(bounds);
	CGFloat height = level.rows * kFXCellHeight - CGRectGetHeight(bounds);
	
	frame.size.width += width;
	frame.size.height += height;
	
	frame.origin.x -= width / 2;
	if (frame.origin.x < 0) {
		frame.origin.x = 0;
	}
	
	frame.origin.y -= height / 2;
	if (frame.origin.y < 0) {
		frame.origin.y = 0;
	}
	
	[self.levelView setFrame:frame];
	[self setNeedsDisplay];
}

- (void)processLevelWithLocation:(CGPoint)location {
	UIView *levelView = self.levelView;
	CGRect frame = levelView.frame;

	NSInteger x = 0;
	NSInteger y = 0;
	
	x = (location.y - frame.origin.y) / kFXCellHeight;
	y = (location.x - frame.origin.x) / kFXCellWidth;
	
	NSLog(@"level: x:%d, y:%d", x, y);
	
	FXPosition *position = [FXPosition positionWithCoordinateX:x CoordinateY:y];
	FXPath *path = [FXPath pathWithLevel:self.level];
	[self noAvailableMoves];
	self.availableMoves = [NSMutableArray arrayWithArray:[path pathToPosition:position]];
	[self setupTimer];
	
	if (nil == self.availableMoves) {
		FXDirection *direction = [FXDirection directionBetweenFromPosition:[self.level playerPosition]
																toPosition:position];
		if (direction) {
			if ([self.level canPushInDirection:direction]) {
				[self.level pushInDirection:direction];
				[self checkNextLevel];
			}
		}
	}
}

#pragma mark -
#pragma mark Private Methods

- (void)noAvailableMoves {
	if (self.availableMoves) {
		self.availableMoves = nil;
	}
}

- (void)setupTimer {
	if (self.availableMoves && [self.availableMoves count] > 0) {
		[NSTimer scheduledTimerWithTimeInterval:kFXTimeInterval
										 target:self
									   selector:@selector(firedTimerWithUserInfo:)
									   userInfo:nil
										repeats:NO];
	} else {
		[self noAvailableMoves];
	}
}

- (void)firedTimerWithUserInfo:(id)userInfo {
	if (self.availableMoves && [self.availableMoves count] > 0) {
		FXDirection *direction = [self.availableMoves objectAtIndex:0];
		[self.availableMoves removeObjectAtIndex:0];
		[self.level walkInDirection:direction];
		[self setupTimer];
	} else {
		[self noAvailableMoves];
	}
}

- (void)checkNextLevel {
	if ([self.level finished]) {
		NSLog(@"level is finished");
		
		self.level.state = kFXLevelDidFinish;
		
		//TODO: change level in user defaults
		//then
		//[self setupFrameWithLevel:self.level];
	}
}

#pragma mark -
#pragma mark FXLevelObserver protocol

- (void)levelDidChange:(id)level {
//	NSLog(@"observer %@ was notifyed with message levelDidChange: from object %@", self, level);
	
	[self setNeedsDisplayInRect:self.levelView.frame];
}

- (void)levelDidFinish:(id)level {
	NSLog(@"observer %@ was notifyed with message levelDidFinish: from object %@", self, level);
	
}

@end
