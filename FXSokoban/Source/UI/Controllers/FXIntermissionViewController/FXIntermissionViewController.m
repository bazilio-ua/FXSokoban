//
//  FXIntermissionViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXIntermissionViewController.h"
#import "FXIntermissionView.h"

#import "FXGameViewController.h"

#import "FXPlayer.h"

#import "UIViewController+FXExtensions.h"

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
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save your result"
														message:@"Please enter your name\n for High-Scores rank:"
													   delegate:self
											  cancelButtonTitle:@"Continue"
											  otherButtonTitles:nil];
	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	UITextField *textField = [alertView textFieldAtIndex:0];
	textField.keyboardType = UIKeyboardTypeDefault;
	textField.placeholder = @"Enter your name";
	
	if (!self.player.name) {
		[alertView show];
	}
	
	[self.player writeDefaults];
	
	self.intermissionView.player = self.player;
	self.intermissionView.stats = self.stats;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (IBAction)onNextLevelButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushGameViewController];
}

#pragma mark -
#pragma mark Private Methods

- (void)pushMainViewController {
	
}

- (void)pushGameViewController {
	FXGameViewController *controller = [FXGameViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)pushHighScoreViewController {
	
}

#pragma mark -
#pragma mark UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *name = [[alertView textFieldAtIndex:0] text];
	NSLog(@"Entered name: %@", name);
	if ([name length]) {
		self.player.name = name;
		
		[self.player writeDefaults];
		
		self.intermissionView.player = self.player;
	}
}

@end
