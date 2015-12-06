//
//  FXIntermissionViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXIntermissionViewController.h"

#import "FXIntermissionView.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXIntermissionViewController, intermissionView, FXIntermissionView);

@interface FXIntermissionViewController ()

- (void)pushMainViewController;
- (void)pushGameViewController;
- (void)pushHighScoreViewController;

@end

@implementation FXIntermissionViewController

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark User Interactions

- (IBAction)onNextLevelButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

#pragma mark -
#pragma mark Private Methods

- (void)pushMainViewController {
	
}

- (void)pushGameViewController {
	
}

- (void)pushHighScoreViewController {
	
}

@end
