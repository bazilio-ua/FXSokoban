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

- (void)setupPlayer;
- (void)pushGameViewController;
- (void)pushHighScoreViewController;

@end

@implementation FXMainViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self setupPlayer];
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
	
}

- (IBAction)onNewGameButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushGameViewController];
}

- (IBAction)onHighScoreButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (IBAction)onQuitButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

#pragma mark -
#pragma mark Private Methods

- (void)setupPlayer {
	self.player = [FXPlayer readDefaults];
}

- (void)pushGameViewController {
	FXGameViewController *controller = [FXGameViewController controller];
	controller.player = self.player;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)pushHighScoreViewController {
	
}

@end
