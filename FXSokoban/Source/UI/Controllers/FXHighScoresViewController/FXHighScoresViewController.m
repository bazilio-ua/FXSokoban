//
//  FXHighScoresViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXHighScoresViewController.h"

#import "FXMainViewController.h"

#import "FXGameCenter.h"

#import "UIViewController+FXExtensions.h"

@interface FXHighScoresViewController ()

- (void)pushMainViewController;
- (void)pushGameCenterViewController;

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
	
}

#pragma mark -
#pragma mark Private Methods

- (void)pushMainViewController {
	FXMainViewController *controller = [FXMainViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)pushGameCenterViewController {
	
}

#pragma mark -
#pragma mark GKGameCenterControllerDelegate protocol

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
	
}

@end
