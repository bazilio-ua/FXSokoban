//
//  FXCell.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXCell : NSObject
@property (nonatomic, readonly, getter = isGround)			BOOL	ground;
@property (nonatomic, readonly, getter = isWall)			BOOL	wall;
@property (nonatomic, readonly, getter = isEmpty)			BOOL	empty;
@property (nonatomic, readonly, getter = isPacket)			BOOL	packet;
@property (nonatomic, readonly, getter = isTarget)			BOOL	target;
@property (nonatomic, readonly, getter = isGoal)			BOOL	goal;
@property (nonatomic, readonly, getter = isPlayer)			BOOL	player;
@property (nonatomic, readonly, getter = isPlayerOnTarget)	BOOL	playerOnTarget;

@property (nonatomic, readonly, getter = isWalkable)		BOOL	walkable;
@property (nonatomic, readonly, getter = isMoveable)		BOOL	moveable;

+ (id)cell;
+ (id)cellWithType:(char)type;
- (id)initWithType:(char)type;

- (NSUInteger)addPacket;
- (NSUInteger)removePacket;

- (void)addPlayer;
- (void)removePlayer;

@end
