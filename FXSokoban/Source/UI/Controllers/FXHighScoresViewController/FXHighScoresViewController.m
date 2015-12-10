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

@end

@implementation FXHighScoresViewController

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark User Interactions

- (IBAction)onMainMenuButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushMainViewController];
}

#pragma mark -
#pragma mark Private Methods

- (void)pushMainViewController {
	FXMainViewController *controller = [FXMainViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

@end
