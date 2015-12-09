//
//  FXViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXViewController.h"

#import "FXPlayer.h"
#import "FXLevel.h"
#import "FXLevelPack.h"

@interface FXViewController ()

@end

@implementation FXViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.stats = nil;
	self.player = nil;
	self.level = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setPlayer:(FXPlayer *)player {
	if (_player != player) {
		_player = player;
	}
	
	self.level = [[FXLevelPack sharedInstance] levelAtIndex:player.levelIndex];
}

- (void)setLevel:(FXLevel *)level {
	if (_level != level) {
		[_level removeObserver:self];
		_level = level;
		[_level addObserver:self];
	}
}

@end
