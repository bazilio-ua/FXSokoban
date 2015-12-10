//
//  FXMainViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXMainViewController.h"
#import "FXMainView.h"

#import "FXGameViewController.h"
#import "FXHighScoresViewController.h"

#import "FXPlayer.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXMainViewController, mainView, FXMainView);

@interface FXMainViewController ()

- (void)pushGameViewController;
- (void)pushHighScoresViewController;
- (void)showNewGameAlertView;

@end

@implementation FXMainViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.player = [FXPlayer readDefaults];
	}
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (IBAction)onContinueButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	if (self.player.name) {
		[self pushGameViewController];
	}
}

- (IBAction)onNewGameButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	if (self.player.name) {
		[self showNewGameAlertView];
	} else {
		self.player = [FXPlayer new];
		[self.player writeDefaults];
		
		[self pushGameViewController];
	}
}

- (IBAction)onHighScoresButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushHighScoresViewController];
}

- (IBAction)onQuitButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	exit(0); // FIXME: Will apple approve this?
}

#pragma mark -
#pragma mark Private Methods

- (void)pushGameViewController {
	FXGameViewController *controller = [FXGameViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)pushHighScoresViewController {
	FXHighScoresViewController *controller = [FXHighScoresViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)showNewGameAlertView {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Start new game?"
														message:@"All current progress will be overwritten"
													   delegate:self
											  cancelButtonTitle:@"No"
											  otherButtonTitles:@"Yes", nil];
	[alertView show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // 'No' button
		return;
	} else if (buttonIndex == 1) {
		self.player = [FXPlayer new];
		[self.player writeDefaults];
		
		[self pushGameViewController];
    }
}

@end
