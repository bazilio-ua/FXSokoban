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
#import "FXMainViewController.h"

#import "FXPlayer.h"
#import "FXLevel.h"
#import "FXStats.h"
#import "FXLevelPack.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXGameViewController, gameView, FXGameView);

@interface FXGameViewController ()
@property (nonatomic, strong)	NSUndoManager	*undoManager;

- (void)pushMainViewController;
- (void)pushIntermissionViewController;
- (void)showCompletedAlertView;

@end

@implementation FXGameViewController

@synthesize undoManager;

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.stats = [FXStats new];
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
	
	self.gameView.player = self.player;
	self.gameView.level = self.level;
	self.gameView.stats = self.stats;
	
	self.undoManager = self.level.undoManager;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	self.gameView.level = self.level;
}

#pragma mark -
#pragma mark User Interactions

- (void)handleTap:(UITapGestureRecognizer *)sender {
//	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	CGPoint location = [sender locationInView:[sender.view superview]];
//	NSLog(@"tap location x:%f, y:%f", location.x, location.y);
	
	[self.gameView processLevelWithLocation:location];
}

- (IBAction)onRestartButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	self.level = [[FXLevelPack sharedInstance] levelAtIndex:self.player.levelIndex];
	self.gameView.level = self.level;
	
	self.undoManager = self.level.undoManager;
}

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

- (void)pushIntermissionViewController {
	FXIntermissionViewController *controller = [FXIntermissionViewController controller];
	controller.player = self.player;
	controller.stats = self.stats;
	
	[self.navigationController pushViewController:controller animated:NO];
}

- (void)showCompletedAlertView {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Well done!"
														message:@"Press OK to continue"
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self pushIntermissionViewController];
	}
}

#pragma mark -
#pragma mark FXLevelObserver protocol

- (void)levelDidChange:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
}

- (void)levelDidFinish:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
//	[self pushIntermissionViewController];
	[self showCompletedAlertView];
}

@end
