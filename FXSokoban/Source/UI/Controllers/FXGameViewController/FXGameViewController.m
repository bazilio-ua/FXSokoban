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
//	[self.view addGestureRecognizer:recognizer];
	[self.gameView.levelView addGestureRecognizer:recognizer];
	
	self.gameView.level = self.level;
	
//	self.gameView.levelView.backgroundColor = [UIColor lightGrayColor];
	
	[self.view addSubview:self.gameView.levelView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (void)handleTap:(UITapGestureRecognizer *)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	CGPoint location = [sender locationInView:[sender.view superview]];
	
	// Do stuff here...
	NSLog(@"location x:%f, y:%f", location.x, location.y);
}

- (void)onUndoButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

@end
