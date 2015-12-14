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

- (void)setGameCenterAuthenticated:(BOOL)gameCenterAuthenticated {
	if (_gameCenterAuthenticated != gameCenterAuthenticated) {
		_gameCenterAuthenticated = gameCenterAuthenticated;
		
		[self updateLeaderboardButton];
	}
}

#pragma mark -
#pragma mark View lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
		
	[self updateLeaderboardButton];
}

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Private Methods

- (void)updateLeaderboardButton {
	[self.leaderboardButton setEnabled:[self isGameCenterAuthenticated]];
}

@end
