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
- (void)setupMovesTimer;
- (void)firedMovesTimerWithUserInfo:(id)userInfo;
- (void)checkFinished;

@end

@implementation FXGameView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.level = nil;
	self.player = nil;
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

#pragma mark -
#pragma mark View lifecycle

- (void)drawRect:(CGRect)rect {
	UIView *levelView = self.levelView;
	CGRect frame = levelView.frame;
	
	FXLevel *level = self.level;
	NSInteger rows = level.rows;
	NSInteger columns = level.columns;
	for (NSInteger row = 0; row < rows; row++) {
		for (NSInteger column = 0; column < columns; column++) {
			CGRect cellRect = CGRectMake(column * kFXCellWidth + frame.origin.x,
										 row * kFXCellHeight + frame.origin.y,
										 kFXCellWidth,
										 kFXCellHeight);
			FXPosition *position = [FXPosition positionWithPointX:row pointY:column];
			FXCell *cell = [level cellAtPosition:position];
			if ([cell isGround]) {
				[[UIColor brownColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isWall]) {
				[[UIColor blackColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isPacket]) {
				[[UIColor orangeColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isTarget]) {
				[[UIColor blueColor] set];
				[[UIBezierPath bezierPathWithRect:cellRect] fill];
			} else if ([cell isGoal]) {
				[[UIColor yellowColor] set];
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
	
	[levelView setFrame:frame];
	[self setNeedsDisplay];
}

- (void)processLevelWithLocation:(CGPoint)location {
	UIView *levelView = self.levelView;
	CGRect frame = levelView.frame;
	
	NSInteger x = (location.y - frame.origin.y) / kFXCellHeight;
	NSInteger y = (location.x - frame.origin.x) / kFXCellWidth;
	NSLog(@"level point: x:%d, y:%d", x, y);
	
	FXLevel *level = self.level;
	FXPosition *position = [FXPosition positionWithPointX:x pointY:y];
	FXPath *path = [FXPath pathWithLevel:level];
	[self noAvailableMoves];
	self.availableMoves = [NSMutableArray arrayWithArray:[path pathToPosition:position]];
	[self setupMovesTimer];
	
	if (!self.availableMoves) {
		FXDirection *direction = [FXDirection directionBetweenFromPosition:[level playerPosition]
																toPosition:position];
		if (direction) {
			if ([level canPushInDirection:direction]) {
				[level pushInDirection:direction];
				[self checkFinished];
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

- (void)setupMovesTimer {
	id availableMoves = self.availableMoves;
	if (availableMoves && [availableMoves count] > 0) {
		[NSTimer scheduledTimerWithTimeInterval:kFXTimeInterval
										 target:self
									   selector:@selector(firedMovesTimerWithUserInfo:)
									   userInfo:nil
										repeats:NO];
	} else {
		[self noAvailableMoves];
	}
}

- (void)firedMovesTimerWithUserInfo:(id)userInfo {
	id availableMoves = self.availableMoves;
	if (availableMoves && [availableMoves count] > 0) {
		FXDirection *direction = [availableMoves objectAtIndex:0];
		[availableMoves removeObjectAtIndex:0];
		[self.level walkInDirection:direction];
		[self setupMovesTimer];
	} else {
		[self noAvailableMoves];
	}
}

- (void)checkFinished {
	if ([self.level finished]) {
		NSLog(@"level is finished");
		
		self.level.state = kFXLevelDidFinish;
	}
}

#pragma mark -
#pragma mark FXLevelObserver protocol

- (void)levelDidChange:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
	[self setNeedsDisplayInRect:self.levelView.frame];
}

- (void)levelDidFinish:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
}

@end
