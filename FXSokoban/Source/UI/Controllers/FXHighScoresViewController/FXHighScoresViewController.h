//
//  FXHighScoresViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "FXViewController.h"

#import "FXGameCenterObserver.h"

@class FXGameCenter;

@interface FXHighScoresViewController : FXViewController <FXGameCenterObserver, GKGameCenterControllerDelegate>
@property (nonatomic, strong)	FXGameCenter	*gameCenter;

- (IBAction)onMainMenuButton:(id)sender;
- (IBAction)onLeaderboardButton:(id)sender;

@end
