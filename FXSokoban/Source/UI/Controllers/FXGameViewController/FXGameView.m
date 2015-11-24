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

- (CGRect)rectForLevelCellAtRow:(NSInteger)row column:(NSInteger)column;

@end

@implementation FXGameView

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		// do level init
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
	FXLevel *level = self.level;
	NSInteger rows = level.rows;
	NSInteger columns = level.columns;
	
	CGRect rect1 = rect;
	CGRect frame = self.levelView.frame;
	
	for (NSInteger row = 0; row < rows; row++) {
		for (NSInteger column = 0; column < columns; column++) {
			NSLog(@"row: %d column: %d", row, column);
			CGRect cellRect = [self rectForLevelCellAtRow:rows - row column:column];
			FXPosition *position = [FXPosition positionWithCoordinateX:row CoordinateY:column];
			FXCell *cell = [level cellAtPosition:position];
			NSLog(@"cell: %@, position x:%d y:%d", [cell description], position.x, position.y);
			if ([cell isStone]) {
				[[UIColor orangeColor] set];
				[UIBezierPath bezierPathWithRect:cellRect];
			}
			
			NSLog(@"coord: x %f y %f", cellRect.origin.x, cellRect.origin.y);
			
		}
	}
	
}

#pragma mark -
#pragma mark Private Methods

- (CGRect)rectForLevelCellAtRow:(NSInteger)row column:(NSInteger)column {
	return CGRectMake(row * kFXCellWidth, column * kFXCellHeight, kFXCellWidth, kFXCellHeight);
}

@end
