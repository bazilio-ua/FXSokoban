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

- (CGRect)rectForLevelCellAtRow:(NSInteger)row column:(NSInteger)column;

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
	
	[self fillWithLevel:level];
}

- (void)drawRect:(CGRect)rect {
	FXLevel *level = self.level;
	NSInteger rows = level.rows;
	NSInteger columns = level.columns;
		
	for (NSInteger row = 0; row < rows; row++) {
		for (NSInteger column = 0; column < columns; column++) {
			NSLog(@"row: %d column: %d", row, column);
			
			CGRect cellRect = [self rectForLevelCellAtRow:rows - row column:column];
			
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
			
			NSLog(@"coord: x %f y %f", cellRect.origin.x, cellRect.origin.y);
		}
	}
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithLevel:(FXLevel *)level {
	CGRect frame = self.levelView.frame;
	CGFloat height = self.level.rows * kFXCellHeight - self.levelView.bounds.size.height;
	CGFloat width = self.level.columns * kFXCellWidth - self.levelView.bounds.size.width;
	frame.size.height += height;
	frame.size.width += width;
	
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

#pragma mark -
#pragma mark Private Methods

- (CGRect)rectForLevelCellAtRow:(NSInteger)row column:(NSInteger)column {
	CGRect frame = self.levelView.frame;
	CGRect bounds = self.levelView.bounds;

	return CGRectMake(row * kFXCellWidth + frame.origin.x, column * kFXCellHeight + frame.origin.y, kFXCellWidth, kFXCellHeight);
//	return CGRectMake(row * kFXCellWidth + frame.origin.y, column * kFXCellHeight + frame.origin.x, kFXCellWidth, kFXCellHeight);
	
}

@end
