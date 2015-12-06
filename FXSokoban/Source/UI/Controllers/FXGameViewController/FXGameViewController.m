//
//  FXGameViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXGameViewController.h"
#import "FXGameView.h"

#import "FXIntermissionViewController.h"

#import "FXStats.h"
#import "FXPlayer.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXGameViewController, gameView, FXGameView);

@interface FXGameViewController ()

- (void)setupStats;
- (void)updatePlayer;
- (void)pushMainViewController;
- (void)pushIntermissionViewController;

@end

@implementation FXGameViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self setupStats];
	}
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																				 action:@selector(handleTap:)];
	[self.gameView.levelView addGestureRecognizer:recognizer];
	[self.view addSubview:self.gameView.levelView];
	
	self.gameView.stats = self.stats;
	self.gameView.player = self.player;
	self.gameView.level = self.level;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	self.gameView.level = self.level; // FIXME: do setupFrame
}

#pragma mark -
#pragma mark User Interactions

- (void)handleTap:(UITapGestureRecognizer *)sender {
//	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	CGPoint location = [sender locationInView:[sender.view superview]];
//	NSLog(@"tap location x:%f, y:%f", location.x, location.y);
	
	[self.gameView processLevelWithLocation:location];
}

- (IBAction)onUndoButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));

	[self pushIntermissionViewController]; //tst!
}

#pragma mark -
#pragma mark Private Methods

- (void)setupStats {
	self.stats = [FXStats new];
}

- (void)updatePlayer {
	[self.player writeDefaults];
}

- (void)pushMainViewController {
	
}

- (void)pushIntermissionViewController {
	FXIntermissionViewController *controller = [FXIntermissionViewController controller];
	controller.player = self.player;
	controller.stats = self.stats;
	
	[self.navigationController pushViewController:controller animated:NO];
}

#pragma mark -
#pragma mark FXLevelObserver protocol

- (void)levelDidChange:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
}

- (void)levelDidFinish:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
	[self updatePlayer]; // TODO: move to intermissionViewController, update it after player is set his name.
	[self pushIntermissionViewController];
}

@end
