//
//  FXHighScoresView.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXHighScoresView.h"

#import "FXGameCenter.h"

@interface FXHighScoresView ()

- (void)updateLeaderboardButton;

@end

@implementation FXHighScoresView

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark Accessors

- (void)setGameCenter:(FXGameCenter *)gameCenter {
	if (_gameCenter != gameCenter) {
		[_gameCenter removeObserver:self];
		_gameCenter = gameCenter;
		[_gameCenter addObserver:self];
	}
	
	[self updateLeaderboardButton];
}

#pragma mark -
#pragma mark View lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
		
}

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Private Methods

- (void)updateLeaderboardButton {
	[self.leaderboardButton setEnabled:self.gameCenter.authenticated];
}

#pragma mark -
#pragma mark FXGameCenterObserver protocol

- (void)gameCenterDidAuthenticate:(id)object {
	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), object);
	
	[self updateLeaderboardButton];
}

@end
