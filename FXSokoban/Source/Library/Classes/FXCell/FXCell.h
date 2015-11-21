//
//  FXCell.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXCell : NSObject
@property (nonatomic, readonly, getter = isEarth)			BOOL	earth;
@property (nonatomic, readonly, getter = isWall)			BOOL	wall;
@property (nonatomic, readonly, getter = isEmpty)			BOOL	empty;
@property (nonatomic, readonly, getter = isStone)			BOOL	stone;
@property (nonatomic, readonly, getter = isTarget)			BOOL	target;
@property (nonatomic, readonly, getter = isGem)				BOOL	gem;
@property (nonatomic, readonly, getter = isPlayer)			BOOL	player;
@property (nonatomic, readonly, getter = isPlayerOnTarget)	BOOL	playerOnTarget;

@property (nonatomic, readonly, getter = isWalkable)		BOOL	walkable;
@property (nonatomic, readonly, getter = isMoveable)		BOOL	moveable;

+ (id)cellWithType:(char)type;
- (id)initWithType:(char)type;

- (NSUInteger)addStone;
- (NSUInteger)removeStone;

- (void)addPlayer;
- (void)removePlayer;

@end
