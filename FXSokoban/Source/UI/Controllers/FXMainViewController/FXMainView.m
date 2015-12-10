//
//  FXMainView.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXMainView.h"

#import "FXPlayer.h"

@implementation FXMainView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.player = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setPlayer:(FXPlayer *)player {
	if (_player != player) {
		_player = player;
	}
	
	[self fillWithPlayer:player];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithPlayer:(FXPlayer *)player {
	[self.continueButton setEnabled:(player.name) ? YES : NO];
}

@end
