//
//  FXIntermissionViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXIntermissionViewController.h"
#import "FXIntermissionView.h"

#import "FXPlayer.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXIntermissionViewController, intermissionView, FXIntermissionView);

@interface FXIntermissionViewController ()

- (void)pushMainViewController;
- (void)pushGameViewController;
- (void)pushHighScoreViewController;
- (void)performAlertView:(UIAlertView *)alertView completion:(void (^)(void))completion;

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
	
//	if (!self.player.name) {
//		[alertView show];
//	}
	
	[self performAlertView:alertView completion:^{
		[self.player writeDefaults];
	}];
	
	NSLog(@"yo");
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

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

- (void)performAlertView:(UIAlertView *)alertView completion:(void (^)(void))completion {
	if (!self.player.name) {
		[alertView show];
	}
	
	if (completion) {
		completion();
	}
}

#pragma mark -
#pragma mark UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *name = [[alertView textFieldAtIndex:0] text];
	NSLog(@"Entered name: %@", name);
	if ([name length]) {
		self.player.name = name;
	}
}

@end
