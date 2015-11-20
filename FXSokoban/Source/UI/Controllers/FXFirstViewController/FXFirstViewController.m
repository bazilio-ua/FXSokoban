//
//  FXFirstViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXFirstViewController.h"

#import "FXFirstView.h"

#import "FXPlayer.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXFirstViewController, firstView, FXFirstView);

@interface FXFirstViewController ()

- (void)setupPlayer;

@end

@implementation FXFirstViewController

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
	
	UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
																					  action:@selector(handleSingleTap:)];
	[self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
	NSLog(@"%@", NSStringFromSelector(_cmd));

	CGPoint location = [recognizer locationInView:[recognizer.view superview]];
	
	// Do stuff here...
	NSLog(@"x:%f, y:%f", location.x, location.y);
}

- (void)onContinueButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onNewGameButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	
}

- (void)onHighScoreButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onQuitButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

#pragma mark -
#pragma mark Private Methods

- (void)setupPlayer {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *name = [userDefaults objectForKey:@"currentPlayer"];
	if ([name length]) {
		self.player = [FXPlayer playerWithName:name];
	}
}

@end
