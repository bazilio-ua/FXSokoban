//
//  FXGameViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXGameViewController.h"

#import "FXGameView.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXGameViewController, gameView, FXGameView);

@interface FXGameViewController ()

@end

@implementation FXGameViewController

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																				 action:@selector(handleTap:)];
	[self.gameView.levelView addGestureRecognizer:recognizer];
	
	self.gameView.level = self.level;
	[self.view addSubview:self.gameView.levelView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self.gameView setupFrameWithLevel:self.level];
}

#pragma mark -
#pragma mark User Interactions

- (void)handleTap:(UITapGestureRecognizer *)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	CGPoint location = [sender locationInView:[sender.view superview]];
	
	// Do stuff here...
	NSLog(@"location x:%f, y:%f", location.x, location.y);
	
	[self.gameView processLevelWithLocation:location];
}

- (void)onUndoButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

#pragma mark -
#pragma mark FXLevelObserver protocol

- (void)levelDidChange:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
}

- (void)levelDidFinish:(id)level {
//	NSLog(@"observer %@ was notifyed with message %@ from object %@", self, NSStringFromSelector(_cmd), level);
	
}

@end
