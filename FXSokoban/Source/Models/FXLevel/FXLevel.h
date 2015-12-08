//
//  FXLevel.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXObservableObject.h"

@class FXCell;
@class FXPosition;
@class FXDirection;

NS_ENUM(NSUInteger, FXLevelState) {
	kFXLevelDidChange,
	kFXLevelDidFinish
};

@interface FXLevel : FXObservableObject
@property (nonatomic, strong)	NSUndoManager	*undoManager;

@property (nonatomic, strong)	FXPosition		*playerPosition;
@property (nonatomic, readonly)	NSInteger		rows;
@property (nonatomic, readonly)	NSInteger		columns;
@property (nonatomic, readonly)	NSUInteger		moves;
@property (nonatomic, readonly)	NSUInteger		pushes;
@property (nonatomic, readonly)	NSUInteger		goals;
@property (nonatomic, readonly)	BOOL			finished;

+ (id)levelWithArray:(NSArray *)array;
- (id)initWithArray:(NSArray *)array;

- (FXLevel *)snapshot;
- (FXCell *)cellAtPosition:(FXPosition *)position;

- (BOOL)canWalkInDirection:(FXDirection *)direction;
- (BOOL)canPushInDirection:(FXDirection *)direction;

- (void)walkInDirection:(FXDirection *)direction;
- (void)pushInDirection:(FXDirection *)direction;
- (void)pullInDirection:(FXDirection *)direction;

- (void)registerUndoActionWithSelector:(SEL)selector direction:(FXDirection *)direction;

@end
