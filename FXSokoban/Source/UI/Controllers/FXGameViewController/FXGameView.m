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

static const NSUInteger kFXCellWidth = 16;
static const NSUInteger kFXCellHeight = 16;

@interface FXGameView ()
@property (nonatomic, strong)	NSMutableArray *availableMoves;

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
			NSLog(@"row: %d column: %d", row, column);
			
			CGRect cellRect = CGRectMake(column * kFXCellWidth + frame.origin.x,
										 row * kFXCellHeight + frame.origin.y,
										 kFXCellWidth,
										 kFXCellHeight);
			
			NSLog(@"coord: x %f y %f", cellRect.origin.x, cellRect.origin.y);
			
			FXPosition *position = [FXPosition positionWithCoordinateX:row CoordinateY:column];
			FXCell *cell = [level cellAtPosition:position];
			NSLog(@"cell: %@, position x:%d y:%d", [cell description], position.x, position.y);
			
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
}

#pragma mark -
#pragma mark Private Methods

@end
