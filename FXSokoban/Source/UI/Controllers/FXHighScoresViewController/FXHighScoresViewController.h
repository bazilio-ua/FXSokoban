//
//  FXHighScoresViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "FXViewController.h"

@interface FXHighScoresViewController : FXViewController <GKGameCenterControllerDelegate>
@property (nonatomic, strong) NSString *currentPlayerID;
@property (nonatomic, assign, getter = isGameCenterAuthenticationComplete) BOOL gameCenterAuthenticationComplete;

+ (BOOL)isGameCenterAvailable;

- (IBAction)onMainMenuButton:(id)sender;
- (IBAction)onLeaderboardButton:(id)sender;

@end
