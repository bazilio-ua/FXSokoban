//
//  FXHighScoresViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXHighScoresViewController.h"
#import "FXHighScoresView.h"

#import "FXMainViewController.h"

#import "FXPlayer.h"
#import "FXGameCenter.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

static NSString * const kFXLeaderboardIdentifier	= @"com.idapgroup.puzzlerific.FXSokobanLeaderboard";

FXViewControllerBaseViewProperty(FXHighScoresViewController, highScoresView, FXHighScoresView);

@interface FXHighScoresViewController ()

- (void)pushMainViewController;
- (void)pushGameCenterViewController;
- (void)submitCurrentScoreToGameCenter;

@end

@implementation FXHighScoresViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// do init
	}
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// FIXME: need redone 
	if ([FXGameCenter isAvailable]) {
		self.gameCenter = [[FXGameCenter alloc] init];
		[self.gameCenter authenticateLocalPlayer];
	} else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Center support required!"
															message:@"For current device Game Center is unavailable."
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (IBAction)onMainMenuButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushMainViewController];
}

- (IBAction)onLeaderboardButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
//	if (!self.gameCenter.authenticationComplete) {
//		return;
//	}
	if (![GKLocalPlayer localPlayer].authenticated) {
		return;
	}
	
	[self pushGameCenterViewController];
	[self submitCurrentScoreToGameCenter];
}

#pragma mark -
#pragma mark Private Methods

- (void)pushMainViewController {
	FXMainViewController *controller = [FXMainViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)pushGameCenterViewController {
    GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
	gameCenterController.leaderboardIdentifier = kFXLeaderboardIdentifier;
    gameCenterController.gameCenterDelegate = self;
	
    [self presentViewController:gameCenterController animated:YES completion:nil];
}

- (void)submitCurrentScoreToGameCenter {
	GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:kFXLeaderboardIdentifier
														  forPlayer:self.gameCenter.currentPlayerID];
	score.value = self.player.totalScore;
	
	if (score.value) {
		[GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
			if (error) {
				NSLog(@"%@", [error localizedDescription]);
			}
		}];
	}
}

#pragma mark -
#pragma mark GKGameCenterControllerDelegate protocol

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
