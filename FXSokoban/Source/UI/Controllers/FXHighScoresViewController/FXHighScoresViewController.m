//
//  FXHighScoresViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXHighScoresViewController.h"

#import "FXMainViewController.h"

#import "UIViewController+FXExtensions.h"

@interface FXHighScoresViewController ()

- (void)pushMainViewController;
- (void)pushGameCenterViewController;

@end

@implementation FXHighScoresViewController

#pragma mark -
#pragma mark Class Methods

+ (BOOL)isGameCenterAvailable {
	static BOOL __available = NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// Check for presence of GKLocalPlayer API.
		Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
		
		// The device must be running running iOS 6.0 or later.
		NSString *requiredSystemVersion = @"6.0";
		NSString *currentSystemVersion = [[UIDevice currentDevice] systemVersion];
		BOOL osVersionSupported = ([currentSystemVersion compare:requiredSystemVersion
														 options:NSNumericSearch] != NSOrderedAscending);
		__available = (gcClass && osVersionSupported);
	});
	
	return __available;
}

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
	
	// do init
	self.gameCenterAuthenticationComplete = NO;
	
	if ([[self class] isGameCenterAvailable]) {
		GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
		
		id authenticateHandler = ^(UIViewController *controller, NSError *error) {
			if (!error) {
				if (controller) {
					[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:controller
																											 animated:YES
																										   completion:nil];
				} else if (localPlayer.isAuthenticated) {
					self.gameCenterAuthenticationComplete = YES;
					if (!self.currentPlayerID || ![self.currentPlayerID isEqualToString:localPlayer.playerID]) {
						self.currentPlayerID = localPlayer.playerID; // player change their ID
					}
				} else {
					self.gameCenterAuthenticationComplete = NO;
				}
			} else {
				NSLog(@"%@", [error localizedDescription]);
			}
		};
		
		[localPlayer setAuthenticateHandler:authenticateHandler];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	self.gameCenterAuthenticationComplete = NO;
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
