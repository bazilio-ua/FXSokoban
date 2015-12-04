//
//  FXPlayer.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/20/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXPlayer : NSObject
@property (nonatomic, copy)		NSString	*name;
@property (nonatomic, assign)	NSUInteger	level;
@property (nonatomic, assign)	NSUInteger	moves;
@property (nonatomic, assign)	NSUInteger	pushes;
@property (nonatomic, assign)	NSUInteger	goals;
@property (nonatomic, assign)	NSUInteger	score;

+ (id)playerWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

+ (id)readDefaults;
- (void)writeDefaults;

@end
