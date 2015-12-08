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

#import "FXPlayer.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXMainViewController, mainView, FXMainView);

@interface FXMainViewController ()

- (void)pushGameViewController;
- (void)pushHighScoreViewController;

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
	
	self.player = [FXPlayer new];
	
	[self pushGameViewController];
}

- (IBAction)onHighScoreButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
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

- (void)pushHighScoreViewController {
	
}

@end
