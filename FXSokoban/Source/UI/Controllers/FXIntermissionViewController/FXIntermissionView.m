//
//  FXIntermissionView.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXIntermissionView.h"

#import "FXPlayer.h"
#import "FXStats.h"

@implementation FXIntermissionView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.player = nil;
	self.stats = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setPlayer:(FXPlayer *)player {
	if (_player != player) {
		_player = player;
	}
	
	[self fillWithPlayer:player];
}

- (void)setStats:(FXStats *)stats {
	if (_stats != stats) {
		_stats = stats;
	}
	
	[self fillWithStats:stats];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithPlayer:(FXPlayer *)player {
	self.nameLabel.text = (player.name) ? [NSString stringWithFormat:@"%@!", player.name] : nil;
	self.levelLabel.text = [NSString stringWithFormat:@"%d", player.levelIndex];
	self.totalScoreLabel.text = [NSString stringWithFormat:@"%d", player.totalScore];
}

- (void)fillWithStats:(FXStats *)stats {
	self.movesLabel.text = [NSString stringWithFormat:@"%d", stats.moves];
	self.pushesLabel.text = [NSString stringWithFormat:@"%d", stats.pushes];
	self.goalsLabel.text = [NSString stringWithFormat:@"%d", stats.goals];
	self.scoreLabel.text = [NSString stringWithFormat:@"%d", stats.score];
}

@end
