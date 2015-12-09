//
//  FXPlayer.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/20/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXPlayer.h"

@implementation FXPlayer

#pragma mark -
#pragma mark Class Methods

+ (id)playerWithName:(NSString *)name {
	return [[self alloc] initWithName:name];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithName:(NSString *)name {
	self = [super init];
	if (self) {
		self.name = name;
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods

+ (id)readDefaults {
	FXPlayer *player = nil;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *dictionary = [defaults dictionaryForKey:@"player"];
	if (dictionary) {
		NSString *name = [dictionary objectForKey:@"name"];
		if ([name length]) {
			player = [FXPlayer playerWithName:name];
			if (player) {
				player.levelIndex = [[dictionary valueForKey:@"levelIndex"] integerValue];
				player.totalScore = [[dictionary valueForKey:@"totalScore"] integerValue];
			}
		}
	}
	
	if (!player) {
		player = [FXPlayer new];
	}
	
	return player;
}

- (void)writeDefaults {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	if (self.name) {
		[dictionary setObject:self.name forKey:@"name"];
		
		[dictionary setObject:[NSNumber numberWithInteger:self.levelIndex] forKey:@"levelIndex"];
		[dictionary setObject:[NSNumber numberWithInteger:self.totalScore] forKey:@"totalScore"];
		NSLog(@"%@", dictionary);
	}
	
	[defaults setObject:dictionary forKey:@"player"];
	[defaults synchronize];
}

@end
